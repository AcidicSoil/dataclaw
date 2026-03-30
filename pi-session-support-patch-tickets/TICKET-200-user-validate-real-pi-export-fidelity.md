---
ticket_id: "tkt_dataclaw_pi_0200"
title: "Confirm pi exports against real session data"
agent: "user"
done: false
goal: "A human validates that native pi exports behave correctly on real pi session data and records any remaining fidelity gaps."
---

## Tasks
- Run the documented real-data checks against actual pi sessions after the implementation and regression tickets are complete.
- Inspect exported results for the source plan’s required behaviors: project grouping, active-leaf ordering, preserved tool calls/results, preserved summaries, sensible final model metadata, and absence of obvious duplication from branch/bash events.
- Record any mismatches as follow-up tickets instead of silently accepting them.

## Acceptance criteria
- Real pi session exports have been reviewed by a human against the behaviors called out in the source plan.
- Any remaining mismatch between exported output and expected pi semantics is captured explicitly as follow-up work.
- Pi support is not treated as complete solely on synthetic fixtures if real-session review reveals gaps.

## Tests
- `uv run dataclaw list --source pi`
- `uv run dataclaw export --source pi --no-push --output /tmp/dataclaw_pi.jsonl`

## Notes
- Source: "Then validate real behavior against actual pi session data"
- Constraints:
  - Use actual pi session data for the final fidelity check.
  - Confirm behavior against the specific inspection points called out in the source plan.
- Evidence:
  - Source file: `Pi Session Support.md`
  - Output artifact to inspect: `/tmp/dataclaw_pi.jsonl`
- Dependencies:
  - `TICKET-180-pi-regression-tests-and-validation.md`
- Unknowns:
  - Availability and shape of real local pi session data are not provided.
