---
ticket_id: "tkt_dataclaw_pi_0180"
title: "Pi support is covered by regression tests and scripted validation"
agent: "codex"
done: false
goal: "Pi support has dedicated parser and CLI coverage, and the documented validation workflow passes in the repo."
---

## Tasks
- Add parser tests in `tests/test_parser.py` for pi discovery, linear parse, toolCall/toolResult handling, model-change handling, compaction handling, active-leaf branch export, malformed JSONL handling, and missing-model fallback.
- Add CLI tests in `tests/test_cli.py` for pi source acceptance, no-projects text, config-step strings, and source-label rendering.
- Add or update any test fixtures needed to represent pi JSONL sessions for the covered scenarios.
- Run the validation commands from the source plan and fix any pi-specific regressions uncovered by those runs.

## Acceptance criteria
- `tests/test_parser.py` contains dedicated pi coverage for every scenario enumerated in the source plan.
- `tests/test_cli.py` contains dedicated pi coverage for every CLI scenario enumerated in the source plan.
- `uv run pytest tests/test_parser.py -k pi`
- `uv run pytest tests/test_cli.py`
- `uv run pytest`
  all complete successfully after the pi patch set is in place.

## Tests
- `uv sync`
- `uv run pytest tests/test_parser.py -k pi`
- `uv run pytest tests/test_cli.py`
- `uv run pytest`

## Notes
- Source: "Add tests before trusting the parser" and "Validate locally"
- Constraints:
  - Add tests before relying on the native pi parser.
  - Keep pi expectations in the existing parser and CLI suites, not ad hoc checks.
- Evidence:
  - Source file: `Pi Session Support.md`
  - Referenced areas: `tests/test_parser.py`, `tests/test_cli.py`
- Dependencies:
  - `TICKET-140-pi-branch-and-tool-fidelity.md`
  - `TICKET-160-pi-cli-and-doc-surface.md`
- Unknowns:
  - Exact fixture shapes for repo-local tests are not provided.
