# Contributing

Negarit AI is proprietary. Contribute only if the copyright holder has invited you.

## Commits

Use Conventional Commits:

```text
type(scope): imperative summary
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.

Keep the subject at or under 72 characters. Explain why in the body.

## Before a commit

- Format and lint the code you touched.
- Run the relevant tests.
- Run `git status` and `git diff --staged`.
- Confirm no `.env`, keystore, or credential file is staged.

## Branches

Short-lived branches from `main`: `feat/<area>-<name>`, `fix/...`, `docs/...`, `chore/...`, `test/...`, `refactor/...`.
