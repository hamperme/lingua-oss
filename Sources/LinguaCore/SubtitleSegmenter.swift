import Foundation

public struct SubtitleSegmentationPolicy: Codable, Equatable, Sendable {
    public var maximumCharacters: Int
    public var maximumDuration: TimeInterval
    public var minimumDuration: TimeInterval
    public var mergeGapThreshold: TimeInterval

    public init(
        maximumCharacters: Int = 42,
        maximumDuration: TimeInterval = 6,
        minimumDuration: TimeInterval = 0.8,
        mergeGapThreshold: TimeInterval = 0.35
    ) {
        self.maximumCharacters = max(8, maximumCharacters)
        self.maximumDuration = max(0.5, maximumDuration)
        self.minimumDuration = max(0, min(minimumDuration, self.maximumDuration))
        self.mergeGapThreshold = max(0, mergeGapThreshold)
    }
}

public struct SubtitleSegmenter: Sendable {
    public let policy: SubtitleSegmentationPolicy

    public init(policy: SubtitleSegmentationPolicy = .init()) {
        self.policy = policy
    }

    public func segment(_ transcript: [TranscriptSegment]) -> [SubtitleCue] {
        let cleaned = transcript
            .filter(\.isFinal)
            .compactMap { segment -> TranscriptSegment? in
                let text = normalizeWhitespace(segment.text)
                guard !text.isEmpty else { return nil }
                return TranscriptSegment(
                    id: segment.id,
                    start: segment.start,
                    end: segment.end,
                    text: text,
                    isFinal: true
                )
            }
            .sorted { lhs, rhs in
                if lhs.start == rhs.start { return lhs.end < rhs.end }
                return lhs.start < rhs.start
            }

        var cues: [SubtitleCue] = []
        for item in cleaned {
            let pieces = splitText(item.text, maximumCharacters: policy.maximumCharacters)
            let duration = max(item.end - item.start, 0.001)

            for (index, piece) in pieces.enumerated() {
                let fractionStart = Double(index) / Double(pieces.count)
                let fractionEnd = Double(index + 1) / Double(pieces.count)
                let start = item.start + duration * fractionStart
                let end = item.start + duration * fractionEnd
                let cue = SubtitleCue(start: start, end: end, sourceText: piece)
                append(cue, to: &cues)
            }
        }

        return applyingMinimumDurations(to: cues)
    }

    private func append(_ cue: SubtitleCue, to cues: inout [SubtitleCue]) {
        guard var previous = cues.last else {
            cues.append(cue)
            return
        }

        let gap = max(0, cue.start - previous.end)
        let combinedText = "\(previous.sourceText) \(cue.sourceText)"
        let combinedDuration = cue.end - previous.start

        let canMerge = gap <= policy.mergeGapThreshold
            && combinedText.count <= policy.maximumCharacters
            && combinedDuration <= policy.maximumDuration

        if canMerge {
            previous.end = max(previous.end, cue.end)
            previous.sourceText = normalizeWhitespace(combinedText)
            cues[cues.count - 1] = previous
        } else {
            cues.append(cue)
        }
    }

    private func applyingMinimumDurations(to cues: [SubtitleCue]) -> [SubtitleCue] {
        guard !cues.isEmpty else { return [] }

        var result = cues
        for index in result.indices where result[index].duration < policy.minimumDuration {
            let desiredEnd = result[index].start + policy.minimumDuration
            if index < result.index(before: result.endIndex) {
                let nextStart = result[result.index(after: index)].start
                result[index].end = max(result[index].end, min(desiredEnd, nextStart))
            } else {
                result[index].end = max(result[index].end, desiredEnd)
            }
        }
        return result
    }

    private func splitText(_ text: String, maximumCharacters: Int) -> [String] {
        guard text.count > maximumCharacters else { return [text] }

        let sentencePieces = text
            .split(whereSeparator: { ".!?。！？".contains($0) })
            .map { normalizeWhitespace(String($0)) }
            .filter { !$0.isEmpty }

        if sentencePieces.count > 1,
           sentencePieces.allSatisfy({ $0.count <= maximumCharacters }) {
            return sentencePieces
        }

        let words = text.split(whereSeparator: \.isWhitespace).map(String.init)
        guard words.count > 1 else {
            return hardSplit(text, maximumCharacters: maximumCharacters)
        }

        var chunks: [String] = []
        var current = ""

        for word in words {
            let candidate = current.isEmpty ? word : "\(current) \(word)"
            if candidate.count <= maximumCharacters {
                current = candidate
            } else {
                if !current.isEmpty { chunks.append(current) }
                if word.count > maximumCharacters {
                    chunks.append(contentsOf: hardSplit(word, maximumCharacters: maximumCharacters))
                    current = ""
                } else {
                    current = word
                }
            }
        }

        if !current.isEmpty { chunks.append(current) }
        return chunks.isEmpty ? [text] : chunks
    }

    private func hardSplit(_ text: String, maximumCharacters: Int) -> [String] {
        var result: [String] = []
        var cursor = text.startIndex
        while cursor < text.endIndex {
            let end = text.index(cursor, offsetBy: maximumCharacters, limitedBy: text.endIndex) ?? text.endIndex
            result.append(String(text[cursor..<end]))
            cursor = end
        }
        return result
    }

    private func normalizeWhitespace(_ text: String) -> String {
        text
            .split(whereSeparator: \.isWhitespace)
            .joined(separator: " ")
    }
}
