# Security Policy

## Supported versions

Lingua OSS is currently pre-1.0. Security fixes are applied to the latest `main` branch and, when releases begin, to the latest supported release line.

## Reporting a vulnerability

Please do **not** open a public issue with exploit details, credentials, private transcripts, or personal audio.

Use GitHub's private security-reporting mechanism if it is enabled for this repository. If private reporting is not available, contact the repository owner privately through GitHub before sharing sensitive details.

A useful report includes:

- affected component and commit/release
- impact and realistic attack scenario
- reproduction steps or a minimal proof of concept
- suggested mitigation, if known
- whether the issue could expose audio, transcript text, credentials, or local files

## Secrets

Never commit API keys, access tokens, signing certificates, provisioning profiles, private model credentials, or production configuration. Provider adapters should read secrets from an environment variable, Keychain, or another appropriate secret store.

## Sensitive data

Treat speech and transcript content as potentially sensitive. Public issues and fixtures must not contain private user data unless it was intentionally created for public redistribution.
