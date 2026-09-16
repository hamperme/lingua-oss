# Architecture

Lingua OSS keeps provider-specific code behind small interfaces so evaluation and subtitle logic can be tested independently.

## Data flow

```text
audio samples
    |
    v
SpeechRecognizing
    |
    v
TranscriptSegment[]
    |
    +--> SubtitleSegmenter --> SubtitleCue[] --> SRTExporter
    |
    v
Translating
    |
    v
InterpretedSegment[]
    |
    v
EvaluationCase[] --> TextEvaluator --> EvaluationSummary
```

## Design goals

### Provider-neutral boundaries

`SpeechRecognizing` and `Translating` are intentionally small. An adapter can wrap Apple frameworks, a local model, or a hosted API without changing the deterministic subtitle and evaluation layers.

### Deterministic core

Segmentation, SRT export, and baseline evaluation do not require network access. This makes regressions easier to reproduce and keeps CI independent of paid services.

### Explicit timing

Transcript and subtitle types keep start/end times as first-class values. Translation latency is tracked separately from media timing so quality and responsiveness can be evaluated independently.

### Public/private separation

This repository is not a mirror of a private product repository. Product UI, release operations, internal datasets, private experiments, credentials, and unpublished commercial implementation details are deliberately excluded.

## Extension points

Useful public extensions include:

- Apple Speech recognizer adapter
- Apple Translation adapter
- local Whisper-compatible recognizer adapter
- hosted model translation adapter
- language-aware subtitle segmentation policies
- semantic evaluation adapters
- richer dataset/fixture provenance metadata

Adapters that contact remote services should make their network and credential behavior explicit and remain optional.
