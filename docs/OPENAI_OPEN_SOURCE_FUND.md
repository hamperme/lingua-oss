# OpenAI Open-Source Project Plan

This document describes a public work plan for Lingua OSS. It is not an approval, endorsement, or commitment from OpenAI.

## Project

Lingua OSS is a privacy-first Swift toolkit for interpretation, subtitle generation, and multilingual evaluation. The public repository focuses on reusable infrastructure rather than a closed product UI.

## Problem

Speech translation quality is not captured well by a single metric. Practical systems need to reason about several failure modes at once:

- semantic omission
- hallucinated content
- meaning drift
- code-switching and named entities
- subtitle boundary quality and readability
- latency and streaming trade-offs
- differences between local/on-device and hosted model paths

Today, many small projects test these dimensions manually or with private scripts. Lingua OSS aims to make a useful subset of that workflow reproducible in public.

## Proposed use of OpenAI API credits

If the project receives API credits through an OpenAI open-source program, credits would be used for public OSS work such as:

1. **Multilingual regression generation** — create diverse, reviewable test cases covering code-switching, numbers, names, idioms, interruptions, and ambiguous phrasing.
2. **Model-assisted evaluation** — compare transparent baseline metrics with rubric-based semantic evaluation for omission, hallucination, and meaning preservation.
3. **Failure analysis** — cluster recurring failure patterns and convert representative failures into checked-in regression tests.
4. **Subtitle-quality evaluation** — evaluate whether cue boundaries preserve complete ideas and remain readable at realistic timing constraints.
5. **Maintainer automation** — use Codex for issue triage, test generation, pull-request review, documentation maintenance, and release preparation.

No credits are requested for hiding product logic behind a hosted service. The goal is to improve the public repository and publish the evaluation methodology, fixtures that can be legally shared, and regression tooling.

## Deliverables

Planned public deliverables include:

- a versioned multilingual evaluation schema
- baseline deterministic metrics
- rubric definitions for semantic completeness and hallucination
- provider-neutral adapters for evaluation
- synthetic/public fixtures with provenance notes
- regression reports that can be reproduced from the repository
- contribution guides for adding new language pairs and failure cases

## Privacy and data handling

Private user audio and transcripts are not appropriate evaluation fixtures. Public evaluation data should be synthetic, explicitly licensed, or otherwise clearly redistributable. API keys must never be committed.

Hosted evaluation adapters should make network use explicit and should allow contributors to run deterministic local-only tests without external services.

## Relationship to Codex open-source programs

OpenAI currently describes the Codex Open Source Fund as a rolling program supporting open-source projects using Codex CLI and OpenAI models, with grants provided as API credits. OpenAI also operates Codex for Open Source for maintainers of active projects with meaningful usage, broad adoption, or clear ecosystem importance.

Lingua OSS is initially targeting the project/fund path while it builds an external contributor and user base. Any application should accurately represent the repository's current adoption and maintenance activity rather than implying traction that does not yet exist.
