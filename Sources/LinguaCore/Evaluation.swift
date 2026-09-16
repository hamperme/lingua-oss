import Foundation

public struct EvaluationCase: Codable, Equatable, Sendable {
    public let id: String
    public let reference: String
    public let candidate: String
    public let latencyMilliseconds: Double?

    public init(
        id: String,
        reference: String,
        candidate: String,
        latencyMilliseconds: Double? = nil
    ) {
        self.id = id
        self.reference = reference
        self.candidate = candidate
        self.latencyMilliseconds = latencyMilliseconds
    }
}

public struct EvaluationCaseScore: Codable, Equatable, Sendable {
    public let id: String
    public let tokenPrecision: Double
    public let tokenRecall: Double
    public let tokenF1: Double
    public let coverage: Double
    public let latencyMilliseconds: Double?
}

public struct EvaluationSummary: Codable, Equatable, Sendable {
    public let caseCount: Int
    public let meanTokenF1: Double
    public let meanCoverage: Double
    public let meanLatencyMilliseconds: Double?
    public let scores: [EvaluationCaseScore]
}

public enum TextEvaluator {
    public static func evaluate(_ cases: [EvaluationCase]) -> EvaluationSummary {
        let scores = cases.map(score)
        let f1 = mean(scores.map(\.tokenF1)) ?? 0
        let coverage = mean(scores.map(\.coverage)) ?? 0
        let latency = mean(scores.compactMap(\.latencyMilliseconds))

        return EvaluationSummary(
            caseCount: scores.count,
            meanTokenF1: f1,
            meanCoverage: coverage,
            meanLatencyMilliseconds: latency,
            scores: scores
        )
    }

    public static func score(_ item: EvaluationCase) -> EvaluationCaseScore {
        let reference = tokens(item.reference)
        let candidate = tokens(item.candidate)

        let overlap = multisetOverlap(reference, candidate)
        let precision = candidate.isEmpty ? (reference.isEmpty ? 1 : 0) : Double(overlap) / Double(candidate.count)
        let recall = reference.isEmpty ? (candidate.isEmpty ? 1 : 0) : Double(overlap) / Double(reference.count)
        let f1: Double
        if precision + recall == 0 {
            f1 = 0
        } else {
            f1 = 2 * precision * recall / (precision + recall)
        }

        return EvaluationCaseScore(
            id: item.id,
            tokenPrecision: precision,
            tokenRecall: recall,
            tokenF1: f1,
            coverage: recall,
            latencyMilliseconds: item.latencyMilliseconds
        )
    }

    public static func tokens(_ text: String) -> [String] {
        text
            .lowercased()
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
    }

    private static func multisetOverlap(_ lhs: [String], _ rhs: [String]) -> Int {
        var remaining: [String: Int] = [:]
        for token in lhs {
            remaining[token, default: 0] += 1
        }

        var overlap = 0
        for token in rhs {
            guard let count = remaining[token], count > 0 else { continue }
            overlap += 1
            if count == 1 {
                remaining.removeValue(forKey: token)
            } else {
                remaining[token] = count - 1
            }
        }
        return overlap
    }

    private static func mean(_ values: [Double]) -> Double? {
        guard !values.isEmpty else { return nil }
        return values.reduce(0, +) / Double(values.count)
    }
}
