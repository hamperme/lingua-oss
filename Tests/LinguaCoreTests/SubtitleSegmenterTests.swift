import XCTest
@testable import LinguaCore

final class SubtitleSegmenterTests: XCTestCase {
    func testMergesNearbyShortSegments() {
        let segmenter = SubtitleSegmenter(
            policy: .init(
                maximumCharacters: 42,
                maximumDuration: 6,
                minimumDuration: 0.5,
                mergeGapThreshold: 0.35
            )
        )

        let transcript = [
            TranscriptSegment(start: 0, end: 1, text: "hello"),
            TranscriptSegment(start: 1.1, end: 2, text: "world")
        ]

        let cues = segmenter.segment(transcript)
        XCTAssertEqual(cues.count, 1)
        XCTAssertEqual(cues[0].sourceText, "hello world")
        XCTAssertEqual(cues[0].start, 0, accuracy: 0.001)
        XCTAssertEqual(cues[0].end, 2, accuracy: 0.001)
    }

    func testSplitsLongSegment() {
        let segmenter = SubtitleSegmenter(
            policy: .init(maximumCharacters: 18, maximumDuration: 6)
        )

        let transcript = [
            TranscriptSegment(
                start: 0,
                end: 4,
                text: "one two three four five six seven eight"
            )
        ]

        let cues = segmenter.segment(transcript)
        XCTAssertGreaterThan(cues.count, 1)
        XCTAssertTrue(cues.allSatisfy { $0.sourceText.count <= 18 })
        XCTAssertEqual(cues.first!.start, 0, accuracy: 0.001)
        XCTAssertEqual(cues.last!.end, 4, accuracy: 0.001)
    }

    func testIgnoresPartialAndEmptySegments() {
        let segmenter = SubtitleSegmenter()
        let transcript = [
            TranscriptSegment(start: 0, end: 1, text: "temporary", isFinal: false),
            TranscriptSegment(start: 1, end: 2, text: "   "),
            TranscriptSegment(start: 2, end: 3, text: "final")
        ]

        let cues = segmenter.segment(transcript)
        XCTAssertEqual(cues.map(\.sourceText), ["final"])
    }
}
