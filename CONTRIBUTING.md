# Contributing to Lingua OSS

Thanks for helping improve Lingua OSS.

## What belongs here

Good contributions are reusable and safe to publish. Examples include:

- subtitle segmentation improvements
- SRT/export correctness fixes
- language-aware text normalization
- transparent evaluation metrics
- synthetic or clearly redistributable evaluation fixtures
- optional provider adapters with documented privacy behavior
- tests, benchmarks, and documentation

Do not submit private product code, credentials, personal transcripts/audio, proprietary datasets, or material you do not have permission to redistribute.

## Development

Requirements:

- Swift 6+
- macOS 14+ or iOS 17+ for Apple-platform integrations

Run the package tests before opening a pull request:

```bash
swift build
swift test
```

The core package should remain testable without network access.

## Pull requests

Keep pull requests focused. Include:

1. a short description of the problem
2. the behavior before and after the change
3. tests for new or changed behavior
4. privacy/network implications, if any
5. dataset or fixture provenance when adding evaluation material

Avoid unrelated formatting or generated-file churn.

## Evaluation fixtures

Every non-synthetic fixture should include enough provenance to determine whether redistribution is allowed. When in doubt, use a small synthetic case instead.

Good regression cases describe the failure mode they are intended to catch, for example:

- omitted number or date
- named-entity corruption
- code-switching loss
- negation reversal
- subtitle split in the middle of a complete idea

## Provider adapters

Remote-service adapters must not hard-code secrets. Document environment variables or secret-store requirements and state what data is transmitted off-device.

## API stability

The project is pre-1.0. Public APIs may evolve, but changes should still be motivated, tested, and documented.

## License of contributions

Unless explicitly stated otherwise, contributions intentionally submitted for inclusion in this project are provided under the Apache License 2.0, consistent with the repository license.
