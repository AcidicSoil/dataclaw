Implemented native Pi session support across DataClaw.

Scope completed:
- Added parser constants for Pi (`PI_SOURCE`, `PI_DIR`, `PI_SESSIONS_DIR`).
- Added Pi project discovery from `~/.pi/agent/sessions` via `_discover_pi_projects()` and source-qualified names via `_build_pi_project_name()`.
- Registered Pi in `discover_projects()` and added explicit Pi routing in `parse_project_sessions()`.
- Implemented `_parse_pi_session_file()` for native Pi JSONL sessions with:
  - session header parsing
  - malformed-line tolerance via existing JSONL iteration behavior
  - normalized user/assistant message export
  - optional thinking preservation
  - model-change handling
  - assistant usage/token stats
  - fallback model `pi-unknown`
  - toolCall/toolResult pairing
  - first-pass `bashExecution`, `compaction`, `branch_summary`, and limited `custom`/`custom_message` handling
  - active-leaf branch export using helper functions `_build_pi_entry_tree()` and `_build_pi_leaf_path()`
- Updated CLI source support to treat `pi` as a first-class source in choices, labels, source checks, and workflow gating text.
- Updated README, AGENTS.md, and docs/SKILL.md so source lists include Pi.
- Added regression tests in `tests/test_parser.py` and `tests/test_cli.py` for Pi discovery, parsing, branch handling, model changes, tool result attachment, malformed input tolerance, and CLI source acceptance.

Validation run:
- `uv run python -m pytest tests/test_parser.py -k pi -q` -> passed
- `uv run python -m pytest tests/test_cli.py -q` -> passed
- `uv run python -m pytest -q` -> 303 passed

Known remaining boundary:
- The ticket for validating against real local Pi session exports was not claimed complete because it requires human inspection of real Pi data outside the repo fixtures.