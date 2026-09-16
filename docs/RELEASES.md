# Release Policy

Lingua OSS follows semantic versioning once tagged releases begin.

Before a release:

- `swift build` succeeds
- `swift test` succeeds
- public API changes are documented
- new fixtures have provenance/license notes
- networked adapters document off-device data handling
- release notes distinguish deterministic evaluation changes from model-assisted evaluation changes

Until `1.0.0`, minor versions may contain source-breaking API changes when they are documented in release notes.
