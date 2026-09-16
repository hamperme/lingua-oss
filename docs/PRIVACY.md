# Privacy Principles

Lingua OSS is designed so that local-only workflows remain possible and obvious.

## Repository policy

This repository must not contain:

- real user transcripts without explicit permission and a clear redistributable license
- personal audio recordings
- API keys, access tokens, certificates, signing material, or credentials
- private product telemetry or analytics exports
- private customer or tester data

Evaluation fixtures should be synthetic, public-domain, or otherwise clearly licensed for redistribution. Add provenance information when a fixture is derived from an external dataset.

## Provider adapters

A provider adapter must document:

- what data leaves the device
- which endpoint or service receives it
- whether audio, text, or both are transmitted
- what credentials are required
- whether the provider may retain data according to its own terms

Provider secrets should be supplied through environment variables, Keychain, or another secret store. They must never be embedded in source code or fixtures.

## Local-first testing

The core package and its default tests do not require a remote service. Deterministic segmentation, export, and baseline evaluation should remain runnable without network access.

## Reporting privacy issues

Do not paste private transcripts, audio, credentials, or security-sensitive logs into a public issue. Follow `SECURITY.md` for sensitive reports.
