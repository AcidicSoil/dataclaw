---
ticket_id: "tkt_dataclaw_pi_0100"
title: "DataClaw discovers pi projects from the native session store"
agent: "codex"
done: false
goal: "DataClaw recognizes pi as a native parser source and can discover pi project directories from the on-disk session store."
---

## Tasks
- Update `dataclaw/parser.py` to add pi source/path constants for the native pi session store under `~/.pi/agent/sessions`.
- Implement `_discover_pi_projects()` to enumerate direct child project directories, count `*.jsonl` session files, sum size, and return the same project metadata shape used by other sources.
- Implement `_build_pi_project_name()` with a `pi:`-prefixed display name using best-effort folder-name handling.
- Register pi project discovery in `discover_projects()`.
- Add `source == PI_SOURCE` routing in `parse_project_sessions()` so pi projects resolve from the pi session directory and annotate parsed sessions with pi project/source metadata before deeper parsing work lands.

## Acceptance criteria
- When `~/.pi/agent/sessions` exists with project subdirectories, project discovery returns pi projects with `dir_name`, `display_name`, `session_count`, `total_size_bytes`, and `source`.
- Pi project names are source-qualified with a `pi:` prefix.
- `parse_project_sessions()` contains an explicit pi path instead of falling through to another source handler.
- Existing non-pi source discovery and routing behavior remains unchanged.

## Tests
- `uv run pytest tests/test_parser.py -k "pi and discovery"`
- Manual check with a temporary pi-style directory tree to confirm project counts and source labels.

## Notes
- Source: "Add native `pi` support ... add `PI_SOURCE`, point it at pi’s on-disk session store, implement `_discover_pi_projects()`"
- Constraints:
  - Use the native pi session store, not the `custom` import shim.
  - Keep pi display names source-qualified.
- Evidence:
  - Source file: `Pi Session Support.md`
  - Referenced areas: `dataclaw/parser.py`
- Dependencies: Not provided
- Unknowns:
  - Exact project-folder decoding beyond a best-effort `pi:<project_dir_name>` prefix is not provided.
