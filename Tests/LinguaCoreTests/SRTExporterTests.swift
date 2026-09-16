import XCTest
@testable import LinguaCore

final class SRTExporterTests: XCTestCase {
    func testExportsTranslationWhenAvailable() throws {
        let cues = [
            SubtitleCue(
                start: 1.25,
                end: 3.5,
                sourceText: "Hello",
                translatedText: "Hola"
            )
        ]

        let output = try SRTExporter.export(cues: cues)
        XCTAssertTrue(output.contains("00:00:01,250 --> 00:00:03,500"))
        XCTAssertTrue(output.contains("Hola"))
    }

    func testFallsBackToSourceText() throws {
        let cues = [
            SubtitleCue(start: 0, end: 1, sourceText: "Hello")
        ]

        let output = try SRTExporter.export(cues: cues)
        XCTAssertTrue(output.contains("Hello"))
    }

    func testRejectsInvalidTiming() {
        let cues = [
            SubtitleCue(start: 1, end: 1, sourceText: "Invalid")
        ]

        XCTAssertThrowsError(try SRTExporter.export(cues: cues))
    }
}
