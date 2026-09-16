import Foundation

public struct TimedWord: Codable, Equatable, Sendable {
    public let text: String
    public let start: TimeInterval
    public let end: TimeInterval

    public init(text: String, start: TimeInterval, end: TimeInterval) {
        self.text = text
        self.start = max(0, start)
        self.end = max(self.start, end)
    }
}

public struct SubtitleCue: Codable, Equatable, Identifiable, Sendable {
    public let id: UUID
    public var start: TimeInterval
    public var end: TimeInterval
    public var sourceText: String
    public var translatedText: String
    public var words: [TimedWord]

    public init(
        id: UUID = UUID(),
        start: TimeInterval,
        end: TimeInterval,
        sourceText: String,
        translatedText: String = "",
        words: [TimedWord] = []
    ) {
        self.id = id
        self.start = max(0, start)
        self.end = max(self.start, end)
        self.sourceText = sourceText
        self.translatedText = translatedText
        self.words = words
    }

    public var duration: TimeInterval {
        end - start
    }

    public func displayText(preferTranslation: Bool = true) -> String {
        let source = sourceText.trimmingCharacters(in: .whitespacesAndNewlines)
        let translation = translatedText.trimmingCharacters(in: .whitespacesAndNewlines)
        if preferTranslation, !translation.isEmpty {
            return translation
        }
        return source
    }
}
