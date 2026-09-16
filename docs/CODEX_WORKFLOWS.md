# Codex Maintainer Workflows

This document captures candidate open-source workflows to evaluate if Codex/OpenAI credits are awarded.

## Failure to regression test

1. maintainer records a small public failure case
2. Codex proposes a minimal regression test
3. maintainer verifies that the test captures the intended failure
4. a human reviews any implementation change
5. the deterministic suite remains the merge gate

## Issue triage

Codex can help summarize duplicate symptoms, identify likely affected components, and suggest missing reproduction details. Sensitive data should never be copied into prompts solely for triage.

## Pull-request review

Potential assistance includes:

- checking test coverage for changed behavior
- spotting missing privacy/network documentation
- flagging fixture provenance gaps
- suggesting edge cases around timing and Unicode text

Human maintainers remain responsible for merge decisions.

## Evaluation expansion

OpenAI models can be used experimentally to score semantic omission, hallucination, and meaning preservation against a published rubric. Reports should record evaluator configuration and keep model judgments separate from deterministic baseline metrics.
