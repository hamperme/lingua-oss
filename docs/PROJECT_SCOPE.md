# Project Scope

Lingua OSS is the reusable open-source layer around interpretation, subtitle, and evaluation problems.

## In scope

- provider-neutral Swift interfaces
- deterministic subtitle processing
- export formats
- evaluation schemas and metrics
- public/synthetic regression fixtures
- optional, clearly documented provider adapters
- tests, benchmarks, and maintainer automation

## Out of scope for this repository

- private Lingua application UI and product-specific workflows
- App Store release operations
- private user/tester data
- proprietary or uncleared datasets
- credentials and signing assets
- unpublished internal experiments
- private commercial implementation details that are not required to use the public package

The public and private repositories may share concepts, but this repository has a clean history and should remain independently understandable and buildable.
