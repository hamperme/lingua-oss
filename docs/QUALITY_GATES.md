# Quality Gates

A change is ready for merge when the relevant gates pass.

## Core code

- package builds with Swift 6+
- all unit tests pass
- deterministic behavior remains network-independent
- public APIs have clear names and Sendable behavior where concurrency is involved

## Subtitle changes

- cue times remain monotonic and non-overlapping within the produced sequence
- no empty export blocks are emitted
- changes include a regression case that explains the readability or timing improvement

## Evaluation changes

- positive and negative examples are included
- metric limitations are documented
- provider/model judgments are not mixed silently with deterministic metrics

## Data and privacy

- fixtures are synthetic or redistributable with provenance
- no user audio/transcripts, credentials, or private product materials are committed
