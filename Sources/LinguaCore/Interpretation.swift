import Foundation

public struct TranscriptSegment: Codable, Equatable, Identifiable, Sendable {
    public let id: UUID
    public let start: TimeInterval
    public let end: TimeInterval
    public let text: String
    public let isFinal: Bool

    public init(
        id: UUID = UUID(),
        start: TimeInterval,
        end: TimeInterval,
        text: String,
        isFinal: Bool = true
    ) {
        self.id = id
        self.start = max(0, start)
        self.end = max(self.start, end)
        self.text = text
        self.isFinal = isFinal
    }
}

public struct TranslationRequest: Codable, Equatable, Sendable {
    public let text: String
    public let sourceLanguage: LinguaLanguage
    public let targetLanguage: LinguaLanguage

    public init(
        text: String,
        sourceLanguage: LinguaLanguage,
        targetLanguage: LinguaLanguage
    ) {
        self.text = text
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
    }
}

public struct TranslationResult: Codable, Equatable, Sendable {
    public let text: String
    public let latencyMilliseconds: Double?

    public init(text: String, latencyMilliseconds: Double? = nil) {
        self.text = text
        self.latencyMilliseconds = latencyMilliseconds
    }
}

public struct InterpretedSegment: Codable, Equatable, Identifiable, Sendable {
    public let id: UUID
    public let start: TimeInterval
    public let end: TimeInterval
    public let sourceText: String
    public let translatedText: String
    public let translationLatencyMilliseconds: Double?

    public init(
        id: UUID = UUID(),
        start: TimeInterval,
        end: TimeInterval,
        sourceText: String,
        translatedText: String,
        translationLatencyMilliseconds: Double? = nil
    ) {
        self.id = id
        self.start = max(0, start)
        self.end = max(self.start, end)
        self.sourceText = sourceText
        self.translatedText = translatedText
        self.translationLatencyMilliseconds = translationLatencyMilliseconds
    }
}

public protocol SpeechRecognizing: Sendable {
    func transcribe(
        samples: [Float],
        sampleRate: Double,
        language: LinguaLanguage
    ) async throws -> [TranscriptSegment]
}

public protocol Translating: Sendable {
    func translate(_ request: TranslationRequest) async throws -> TranslationResult
}

public actor InterpretationPipeline {
    private let recognizer: any SpeechRecognizing
    private let translator: any Translating

    public init(
        recognizer: any SpeechRecognizing,
        translator: any Translating
    ) {
        self.recognizer = recognizer
        self.translator = translator
    }

    public func process(
        samples: [Float],
        sampleRate: Double,
        sourceLanguage: LinguaLanguage,
        targetLanguage: LinguaLanguage
    ) async throws -> [InterpretedSegment] {
        let transcript = try await recognizer.transcribe(
            samples: samples,
            sampleRate: sampleRate,
            language: sourceLanguage
        )

        var output: [InterpretedSegment] = []
        output.reserveCapacity(transcript.count)

        for segment in transcript where segment.isFinal {
            let source = segment.text.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !source.isEmpty else { continue }

            let result = try await translator.translate(
                TranslationRequest(
                    text: source,
                    sourceLanguage: sourceLanguage,
                    targetLanguage: targetLanguage
                )
            )

            output.append(
                InterpretedSegment(
                    start: segment.start,
                    end: segment.end,
                    sourceText: source,
                    translatedText: result.text,
                    translationLatencyMilliseconds: result.latencyMilliseconds
                )
            )
        }

        return output
    }
}
