# Provider Adapter Guide

LinguaCore intentionally exposes small provider-neutral interfaces.

## Speech recognition

Implement `SpeechRecognizing` and return timestamped `TranscriptSegment` values. An adapter should document whether recognition is on-device or remote and whether raw audio is transmitted.

## Translation

Implement `Translating` and return `TranslationResult`. If the provider exposes request latency, include it in `latencyMilliseconds` so the same pipeline can feed evaluation reports.

## Secrets

Do not hard-code API keys. Prefer environment variables for CLI/demo adapters and Keychain or another appropriate secret store for applications.

## Optional dependencies

Provider SDKs should live in separate targets when practical so the deterministic `LinguaCore` target stays dependency-light and network-independent.

## Tests

Adapters should use fakes/mocks for default unit tests. Live integration tests must be opt-in and must never assume a maintainer's credentials are present.
