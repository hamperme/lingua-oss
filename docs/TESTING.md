# Testing

Run the default suite with:

```bash
swift test
```

The default suite is designed to run without network credentials.

## Test categories

- subtitle segmentation behavior
- subtitle export correctness
- baseline text-evaluation metrics
- provider adapter contract tests (future)
- multilingual regression fixtures (future)

When adding a bug fix, prefer a small test that fails before the fix and explains the user-visible failure mode.
