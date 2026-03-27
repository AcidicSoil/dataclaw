# DataClaw style and conventions

- Language/style: straightforward Python with standard-library-first implementation style.
- Typing: type hints are used throughout, including modern built-in generics like `list[dict]`, `dict[str, Any]`, `str | None`, and typed constants.
- Docstrings: short triple-quoted docstrings are common for modules and functions; they are concise and behavior-focused.
- Naming:
  - module-level constants are `UPPER_SNAKE_CASE`
  - functions and variables are `snake_case`
  - helper/parsing functions are often prefixed with `_`
  - source identifiers are string constants like `CLAUDE_SOURCE`, `CODEX_SOURCE`, etc.
- File organization:
  - `cli.py` keeps argument handling plus workflow/status helper logic together.
  - `parser.py` contains one discovery path and one parse path per supported source, plus shared normalization helpers.
- Tests: pytest-style test files under `tests/`, with focused unit tests and monkeypatch-heavy CLI tests.
- Change preference inferred from repo: keep changes small and source-specific, preserve existing naming/patterns, and extend enumerations/branches/tests together when adding a new supported source.