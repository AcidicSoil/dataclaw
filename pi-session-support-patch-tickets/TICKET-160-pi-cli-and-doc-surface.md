---
ticket_id: "tkt_dataclaw_pi_0160"
title: "Pi is exposed as a first-class DataClaw source in CLI and docs"
agent: "codex"
done: false
goal: "Users can select `pi` through the normal DataClaw interfaces and see pi listed anywhere supported sources are documented."
---

## Tasks
- Update `dataclaw/cli.py` to include `pi` anywhere source choices are validated or rendered, including explicit source lists, all-source lists, labels, and human-readable source text.
- Update any source-related user-facing messages or config-step text that currently omit pi.
- Patch README/manual usage text and any assistant/skill text in the repo that enumerates valid DataClaw sources so pi is listed consistently with the current source set.

## Acceptance criteria
- `--source pi` is accepted anywhere the CLI currently accepts first-class source names.
- CLI source labels and human-readable source lists include pi.
- README/manual/skill source lists no longer advertise a supported-source set that omits pi.
- Parser-side pi support is reachable from normal CLI usage rather than only from internal calls.

## Tests
- `uv run pytest tests/test_cli.py -k pi`
- Manual check of `uv run dataclaw list --source pi --help` or the equivalent CLI entry path to confirm acceptance.

## Notes
- Source: "Patch CLI source support in `dataclaw/cli.py` ... Update source lists in README / skill text"
- Constraints:
  - Pi must work as a first-class source name, not as an undocumented internal-only parser path.
- Evidence:
  - Source file: `Pi Session Support.md`
  - Referenced areas: `dataclaw/cli.py`, README, manual usage text, assistant workflow text
- Dependencies:
  - `TICKET-100-pi-project-discovery-and-parser-routing.md`
- Unknowns: Not provided
