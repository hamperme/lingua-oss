import Foundation

public struct LinguaLanguage: Codable, Hashable, Identifiable, Sendable {
    public let id: String
    public let displayName: String
    public let localeIdentifier: String

    public init(
        id: String,
        displayName: String,
        localeIdentifier: String? = nil
    ) {
        self.id = id
        self.displayName = displayName
        self.localeIdentifier = localeIdentifier ?? id
    }
}

public extension LinguaLanguage {
    static let english = LinguaLanguage(id: "en", displayName: "English")
    static let spanish = LinguaLanguage(id: "es", displayName: "Spanish")
    static let french = LinguaLanguage(id: "fr", displayName: "French")
    static let german = LinguaLanguage(id: "de", displayName: "German")
    static let italian = LinguaLanguage(id: "it", displayName: "Italian")
    static let portugueseBrazil = LinguaLanguage(id: "pt-BR", displayName: "Portuguese (Brazil)")
    static let chineseSimplified = LinguaLanguage(id: "zh-Hans", displayName: "Chinese (Simplified)")
    static let chineseTraditional = LinguaLanguage(id: "zh-Hant", displayName: "Chinese (Traditional)")
    static let japanese = LinguaLanguage(id: "ja", displayName: "Japanese")
    static let korean = LinguaLanguage(id: "ko", displayName: "Korean")
    static let vietnamese = LinguaLanguage(id: "vi", displayName: "Vietnamese")
    static let hindi = LinguaLanguage(id: "hi", displayName: "Hindi")
    static let arabic = LinguaLanguage(id: "ar", displayName: "Arabic")

    static let common: [LinguaLanguage] = [
        .english,
        .spanish,
        .french,
        .german,
        .italian,
        .portugueseBrazil,
        .chineseSimplified,
        .chineseTraditional,
        .japanese,
        .korean,
        .vietnamese,
        .hindi,
        .arabic
    ]
}
