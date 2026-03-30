---
ticket_id: "tkt_dataclaw_pi_0140"
title: "Pi exports preserve active-leaf history and tool execution context"
agent: "codex"
done: false
goal: "Pi exports retain the active branch path, tool interactions, and summary events needed for a faithful first-pass native export."
---

## Tasks
- Add helper logic in `dataclaw/parser.py` to build the pi entry tree from `id`/`parentId`, identify the active leaf with the source’s recommended v1 heuristic, and export only that leaf path.
- Convert assistant `toolCall` content blocks into normalized `tool_uses`.
- Collect and attach matching `toolResult` payloads to their corresponding tool uses instead of emitting them as unrelated standalone messages.
- Preserve `compaction` and `branch_summary` entries as synthetic assistant messages using the summary content described in the source plan.
- Handle `bashExecution` with the v1 fallback described in the source plan so it is preserved without obvious duplication.
- Handle `custom`/`custom_message` entries only to the limited first-pass extent explicitly described in the source plan.

## Acceptance criteria
- Branched pi sessions export only the active leaf path rather than all branches merged together.
- Assistant tool calls in exported sessions include matched tool-result payloads when present.
- Compaction and branch-summary content is preserved in exported output as synthetic assistant-visible context.
- Bash/custom handling follows the documented first-pass behavior and does not introduce obvious duplicated conversation text.
- The parser does not assume Claude-style flat log semantics for pi sessions.

## Tests
- `uv run pytest tests/test_parser.py -k "pi and (branch or tool or compaction)"`
- Add fixture coverage for a branched session, an assistant toolCall/toolResult pair, and summary-event handling.

## Notes
- Source: "The exported conversation should follow the current leaf path, not every branch in the file"
- Constraints:
  - Do not dump every branch into one conversation.
  - Do not ignore `toolResult` when the assistant emitted `toolCall`.
- Evidence:
  - Source file: `Pi Session Support.md`
  - Recommended helpers: `_build_pi_leaf_path()`, `_collect_pi_tool_results()`, `_flatten_pi_content_blocks()`
- Dependencies:
  - `TICKET-120-pi-linear-session-normalization.md`
- Unknowns:
  - Exact matching rules for `bashExecution` to prior tool calls are not fully specified.
  - Nonessential `custom` entry handling is intentionally limited in v1.
