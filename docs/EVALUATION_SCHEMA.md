# Evaluation Schema

The current CLI accepts a deliberately small JSON schema:

```json
[
  {
    "id": "example",
    "reference": "expected meaning",
    "candidate": "system output",
    "latencyMilliseconds": 420
  }
]
```

## Design direction

A future versioned schema should add optional metadata without making simple fixtures cumbersome. Candidate fields include:

- source language and target language
- source utterance
- category tags such as `number`, `named-entity`, `negation`, `code-switching`, or `idiom`
- fixture provenance and redistribution license
- expected semantic facts
- forbidden hallucinated facts
- subtitle timing/readability constraints
- provider/model metadata kept separate from the reference case

## Principles

1. **Human-readable:** fixtures should be understandable in code review.
2. **Provider-neutral:** a case should not require one vendor or model.
3. **Reproducible:** deterministic baselines should run without network access.
4. **Privacy-safe:** public fixtures must not contain private user conversations.
5. **Versioned:** schema changes should preserve the ability to reproduce older reports.
