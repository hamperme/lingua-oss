# Maintenance Workflow

Lingua OSS uses a regression-first maintenance style.

## For bugs

1. reduce the problem to the smallest public/synthetic reproduction
2. add or update a failing test
3. implement the smallest reusable fix
4. run the complete test suite
5. document privacy, network, and fixture-provenance implications

## For evaluation changes

Metric changes should explain what failure mode they capture, what they do not capture, and how they behave on at least one positive and one negative case.

## For model-assisted evaluation

Model-assisted scores should not silently replace deterministic metrics. Reports should distinguish deterministic measurements from model judgments and record the evaluator configuration required to reproduce the latter.

## Human responsibility

Automation, including Codex-assisted review or test suggestions, can reduce maintenance load but does not replace maintainer responsibility for accepting changes, licensing fixtures, or making privacy/security decisions.
