# Lingua OSS

Privacy-first building blocks for real-time interpretation, subtitle generation, and multilingual evaluation on Apple platforms.

> **Public OSS extraction.** This repository is intentionally separate from the private Lingua product repository. It contains reusable core abstractions, subtitle tooling, evaluation utilities, tests, and public documentation. Product-specific UI, release operations, private datasets, internal experiments, credentials, and unpublished commercial implementation details are not included.

## Why this exists

Real-time interpretation systems are difficult to evaluate well. Word-level accuracy alone does not capture subtitle readability, semantic completeness, latency, omissions, or the trade-offs between on-device and hosted models.

Lingua OSS provides a small, inspectable foundation for experimenting with those problems:

- language and interpretation data models
- protocol-based speech recognition and translation boundaries
- timestamped subtitle cues
- deterministic subtitle segmentation
- SRT export
- lightweight text-quality and latency evaluation
- a command-line evaluation target
- unit tests designed for regression-driven development

The package is deliberately model-agnostic. Apple Speech/Translation, local models, or hosted model providers can be implemented behind the same public interfaces without putting provider credentials or private product code in this repository.

## Status

**Early public release.** The package is suitable for experimentation and contribution, but its APIs may still evolve before `1.0.0`.

The private Lingua application has informed these abstractions, but this repository has a clean public history and a narrower scope so contributors can work on reusable infrastructure without inheriting product-specific material.

## Requirements

- Swift 6 or later
- macOS 14+ or iOS 17+

## Build and test

```bash
swift build
swift test
```

## Evaluation CLI

A small executable target evaluates candidate translations/subtitles against references using transparent baseline metrics.

```bash
swift run lingua-eval Fixtures/eval-sample.json
```

The baseline evaluator reports token F1, coverage, and latency summaries. These metrics are intentionally simple and auditable; they are a starting point for richer multilingual and model-assisted evaluation.

## Package layout

```text
Sources/
  LinguaCore/       Reusable interpretation, subtitle, and evaluation primitives
  LinguaEvalCLI/    Minimal evaluation command-line tool
Tests/
  LinguaCoreTests/  Regression tests
Fixtures/           Small synthetic/public test fixtures
docs/               Architecture, privacy, and evaluation roadmap
```

## OpenAI / Codex open-source work

A major goal of this repository is to make multilingual interpretation evaluation reproducible. Potential open-source work includes:

- generating diverse multilingual regression cases
- detecting omission, hallucination, and meaning drift
- evaluating subtitle semantic completeness and readability
- comparing local/on-device and hosted model paths
- turning failures into regression tests
- using Codex to help review failures, propose tests, and improve contributor workflows

See [`docs/OPENAI_OPEN_SOURCE_FUND.md`](docs/OPENAI_OPEN_SOURCE_FUND.md) for the public project plan.

## Privacy principles

Lingua OSS does not require analytics, a Lingua-operated backend, or stored user transcripts. Provider adapters should document clearly when audio or text leaves the device. See [`docs/PRIVACY.md`](docs/PRIVACY.md).

## Contributing

Contributions are welcome. Please read [`CONTRIBUTING.md`](CONTRIBUTING.md) and the [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md). Good first contributions include additional segmentation tests, language-aware tokenization improvements, evaluation fixtures, and provider adapters that keep secrets out of source control.

## Security

Please do not open public issues containing API keys, private transcripts, personal audio, or security-sensitive details. See [`SECURITY.md`](SECURITY.md).

## License

Licensed under the Apache License 2.0. See [`LICENSE`](LICENSE).
