# Baseline Metrics

The initial evaluator intentionally uses simple metrics that are easy to inspect.

## Token precision

The fraction of candidate tokens that can be matched to reference tokens using multiset overlap.

## Token recall / coverage

The fraction of reference tokens recovered by the candidate. The initial `coverage` field is equal to token recall.

## Token F1

The harmonic mean of token precision and token recall.

## Latency

Optional request/output latency reported in milliseconds and averaged across cases that provide it.

## Limitations

These metrics do not reliably capture paraphrase quality, semantic equivalence, negation reversal, factual hallucination, or languages where whitespace-based tokenization is insufficient. Those limitations are intentional roadmap items rather than hidden assumptions.
