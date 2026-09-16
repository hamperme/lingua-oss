# Starter Contribution Areas

These are intentionally scoped so a contributor can improve Lingua OSS without access to the private Lingua product repository.

## Language-aware tokenization

The baseline evaluator currently uses a simple Unicode alphanumeric tokenizer. Improve behavior for Chinese, Japanese, Korean, Thai, and mixed-script text while keeping the implementation transparent and dependency-light.

Acceptance criteria:

- existing English/Spanish tests continue to pass
- new CJK/mixed-script fixtures demonstrate the improvement
- behavior is deterministic and documented

## Subtitle semantic-boundary tests

Add synthetic cases where naive character limits split a complete thought at a poor location. Propose a deterministic improvement or measurable readability rule.

Acceptance criteria:

- fixtures are synthetic or clearly redistributable
- current behavior is captured in a regression test
- the proposed change does not create overlapping cue times

## Evaluation schema provenance

Prototype a versioned fixture schema that records language pair, failure-mode tags, and provenance/license metadata while remaining human-readable in pull requests.

Acceptance criteria:

- old simple fixtures remain easy to migrate
- no provider-specific requirement is introduced
- schema validation has tests
