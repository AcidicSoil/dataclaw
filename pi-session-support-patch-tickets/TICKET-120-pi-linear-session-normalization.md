---
ticket_id: "tkt_dataclaw_pi_0120"
title: "Pi session files export as normalized DataClaw sessions"
agent: "codex"
done: false
goal: "A pi session file can be parsed into DataClaw’s normalized session shape with stable metadata, basic message content, and stats."
---

## Tasks
- Implement `_parse_pi_session_file()` in `dataclaw/parser.py` to read the pi JSONL header and emit DataClaw’s normalized session result shape.
- Initialize `session_id`, `start_time`, and `cwd` from the pi session header and set `git_branch` only if explicit metadata is discovered.
- Parse linear message/content handling for first-pass entry types needed for basic export: `message` and `model_change`.
- Map `user` and `assistant` message roles into normalized DataClaw messages, flattening assistant text content and preserving optional thinking only when `include_thinking=True`.
- Track current/final model metadata from assistant messages and `model_change` entries, and provide the fallback model value described in the source test plan when no assistant model is present.
- Populate session stats for user messages, assistant messages, tool-use count, and token usage from assistant usage fields.
- Skip malformed JSONL lines safely instead of aborting the session parse.

## Acceptance criteria
- A pi JSONL session with a valid header and linear user/assistant exchange exports a normalized session object containing `session_id`, `model`, `git_branch`, `start_time`, `end_time`, `messages`, and `stats`.
- User and assistant messages appear in conversation order with flattened text content.
- Model changes update the exported session model metadata.
- Missing assistant model metadata falls back to the synthetic default described in the source plan.
- Malformed JSONL lines do not prevent the rest of the session from being exported.

## Tests
- `uv run pytest tests/test_parser.py -k "pi and (linear or model_change or malformed)"`
- Add fixture coverage for a simple user→assistant session, a model-change session, and a malformed-line session.

## Notes
- Source: "Use pi’s JSONL session model, but emit DataClaw’s normalized output shape"
- Constraints:
  - Preserve pi metadata fidelity in the normalized DataClaw format.
  - Do not assume git branch metadata unless it is explicitly present.
- Evidence:
  - Source file: `Pi Session Support.md`
  - Referenced areas: `dataclaw/parser.py`, `_make_session_result()`
- Dependencies:
  - `TICKET-100-pi-project-discovery-and-parser-routing.md`
- Unknowns:
  - Exact location of git branch metadata in pi session files is not provided.
