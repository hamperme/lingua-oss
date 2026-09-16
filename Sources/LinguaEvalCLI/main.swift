import Foundation
import LinguaCore

@main
struct LinguaEvalCLI {
    static func main() throws {
        let arguments = CommandLine.arguments
        guard arguments.count == 2 else {
            FileHandle.standardError.write(
                Data("Usage: lingua-eval <evaluation-cases.json>\n".utf8)
            )
            Foundation.exit(2)
        }

        let url = URL(fileURLWithPath: arguments[1])
        let data = try Data(contentsOf: url)
        let cases = try JSONDecoder().decode([EvaluationCase].self, from: data)
        let summary = TextEvaluator.evaluate(cases)

        print("cases: \(summary.caseCount)")
        print(String(format: "mean token F1: %.3f", summary.meanTokenF1))
        print(String(format: "mean coverage: %.3f", summary.meanCoverage))
        if let latency = summary.meanLatencyMilliseconds {
            print(String(format: "mean latency: %.1f ms", latency))
        } else {
            print("mean latency: n/a")
        }

        for score in summary.scores {
            let latency = score.latencyMilliseconds.map { String(format: "%.1f ms", $0) } ?? "n/a"
            print(
                String(
                    format: "%@  F1=%.3f  coverage=%.3f  latency=%@",
                    score.id,
                    score.tokenF1,
                    score.coverage,
                    latency
                )
            )
        }
    }
}
