import Foundation

public enum SRTExporterError: Error, Equatable, Sendable {
    case empty
    case invalidTiming(index: Int)
}

public enum SRTExporter {
    public static func export(
        cues: [SubtitleCue],
        preferTranslation: Bool = true
    ) throws -> String {
        guard !cues.isEmpty else { throw SRTExporterError.empty }

        var blocks: [String] = []
        blocks.reserveCapacity(cues.count)

        for (offset, cue) in cues.enumerated() {
            guard cue.start >= 0, cue.end > cue.start else {
                throw SRTExporterError.invalidTiming(index: offset)
            }

            let text = cue.displayText(preferTranslation: preferTranslation)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            guard !text.isEmpty else { continue }

            blocks.append(
                """
                \(blocks.count + 1)
                \(timestamp(cue.start)) --> \(timestamp(cue.end))
                \(text)
                """
            )
        }

        guard !blocks.isEmpty else { throw SRTExporterError.empty }
        return blocks.joined(separator: "\n\n") + "\n"
    }

    public static func timestamp(_ seconds: TimeInterval) -> String {
        let totalMilliseconds = max(0, Int((seconds * 1000).rounded()))
        let milliseconds = totalMilliseconds % 1000
        let totalSeconds = totalMilliseconds / 1000
        let secondsPart = totalSeconds % 60
        let totalMinutes = totalSeconds / 60
        let minutes = totalMinutes % 60
        let hours = totalMinutes / 60

        return String(
            format: "%02d:%02d:%02d,%03d",
            hours,
            minutes,
            secondsPart,
            milliseconds
        )
    }
}
