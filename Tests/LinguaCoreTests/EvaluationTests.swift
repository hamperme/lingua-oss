import XCTest
@testable import LinguaCore

final class EvaluationTests: XCTestCase {
    func testExactMatchScoresOne() {
        let item = EvaluationCase(
            id: "exact",
            reference: "the quick brown fox",
            candidate: "The quick brown fox"
        )

        let score = TextEvaluator.score(item)
        XCTAssertEqual(score.tokenPrecision, 1, accuracy: 0.0001)
        XCTAssertEqual(score.tokenRecall, 1, accuracy: 0.0001)
        XCTAssertEqual(score.tokenF1, 1, accuracy: 0.0001)
        XCTAssertEqual(score.coverage, 1, accuracy: 0.0001)
    }

    func testOmissionLowersRecall() {
        let item = EvaluationCase(
            id: "omission",
            reference: "please close the door quietly",
            candidate: "close the door"
        )

        let score = TextEvaluator.score(item)
        XCTAssertLessThan(score.tokenRecall, 1)
        XCTAssertGreaterThan(score.tokenPrecision, score.tokenRecall)
    }

    func testSummaryAveragesLatencyWhenPresent() {
        let summary = TextEvaluator.evaluate([
            EvaluationCase(id: "a", reference: "hello", candidate: "hello", latencyMilliseconds: 100),
            EvaluationCase(id: "b", reference: "world", candidate: "world", latencyMilliseconds: 300)
        ])

        XCTAssertEqual(summary.caseCount, 2)
        XCTAssertEqual(summary.meanLatencyMilliseconds, 200)
    }
}
