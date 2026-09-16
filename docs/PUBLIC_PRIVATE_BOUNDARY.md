# Public / Private Boundary

The repository split is intentional.

## Private Lingua repository

Used for the full personal/product application, internal release preparation, private experiments, and material that is not required for public reuse.

## Lingua OSS repository

Used for reusable interpretation/subtitle/evaluation infrastructure that can be reviewed, tested, and contributed to publicly.

Nothing in Lingua OSS should require access to the private repository to understand the public API or run the default test suite.

When moving an idea from the private project into Lingua OSS, rewrite or extract the smallest reusable component and re-check it for credentials, personal data, proprietary material, and dataset/model licensing before publication.
