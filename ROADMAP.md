# Roadmap

Lingua OSS is early-stage. The roadmap prioritizes reproducible evaluation and reusable infrastructure over product UI.

## Near term

- improve tokenization for CJK and languages where whitespace is not a reliable token boundary
- add semantic-completeness evaluation rubrics for omission, hallucination, negation, numbers, and named entities
- add a versioned evaluation-case schema with provenance metadata
- add optional Apple Speech and Apple Translation adapters in separate targets
- add subtitle readability metrics for cue length, timing, and sentence-boundary quality
- publish small synthetic multilingual regression packs

## Maintainer tooling

- automate regression summaries for pull requests
- turn confirmed failures into suggested test cases
- add release notes and API-change checks
- evaluate Codex-assisted issue triage and pull-request review while keeping human maintainers responsible for merge decisions

## Later

- local-model adapters with clearly documented model licensing
- richer streaming latency instrumentation
- benchmark reports comparing provider/model paths on the same public fixtures
- contributor-maintained language-pair suites

The roadmap is intentionally provider-neutral. OpenAI API credits, if awarded, would accelerate public evaluation and maintainer tooling rather than making the core package dependent on a hosted service.
