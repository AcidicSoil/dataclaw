# Hermes and DataClaw Integration

**Created:** 3/27/2026 10:15:07  
**Updated:** 3/27/2026  

## Original question

How should `hermes-agent` sessions be added as a config option in DataClaw, and are Hermes sessions already detected automatically because Hermes can use the same underlying providers/models?

## Answer

Hermes sessions were **not** previously auto-detected by provider overlap. DataClaw is parser-and-storage driven, not provider driven, so Hermes needed a first-class source adapter.

That first-pass adapter is now implemented.

## What is implemented

### New DataClaw source

DataClaw now supports:

- `dataclaw config --source hermes`
- `dataclaw prep --source hermes`
- `dataclaw export --source hermes --no-push`
- inclusion of Hermes in `all`

### Storage backend used

The implementation uses Hermes SQLite as the primary source of truth:

- `~/.hermes/state.db`

This matches Hermes’ actual storage model and avoids relying on transcript compatibility.

### Discovery model

Hermes “projects” are currently grouped by Hermes session source/platform.

Examples:

- `hermes:cli`
- `hermes:discord`
- `hermes:telegram`
- `hermes:slack`
- `hermes:whatsapp`
- any other `sessions.source` values present in the Hermes DB

This was chosen because Hermes does not organize history like Claude/Codex project folders, and `sessions.source` is the cleanest stable grouping key already present in the database.

### Session parsing

Hermes sessions are parsed from SQLite and mapped into DataClaw’s normalized schema with:

- `session_id`
- `model`
- `git_branch` (`None` in the first pass)
- `start_time`
- `end_time`
- `messages`
- `stats`

First-pass message handling includes:

- user messages
- assistant messages
- assistant reasoning mapped to `thinking` when enabled
- Hermes `tool_calls` mapped into DataClaw `tool_uses`
- Hermes tool-role rows mapped into assistant tool output entries

### Files changed

Implementation landed in:

- `dataclaw/parser.py`
- `dataclaw/cli.py`
- `tests/test_parser.py`
- `tests/test_cli.py`

## Validation

Validated with:

```bash
PYTHONPATH=. pytest tests/test_parser.py tests/test_cli.py
```

Result:

- `182 passed`

## Current limitations

This is intentionally a conservative first pass.

Not yet modeled:

- Hermes lineage via `parent_session_id`
- Hermes transcript-directory fallback parsing from `~/.hermes/sessions/`
- Hermes-specific `git_branch` extraction
- richer tool-result reconstruction beyond the normalized shape already supported by the tests

## Why this was the right approach

- Hermes does **not** write sessions into Claude/Codex/Gemini app stores in a way DataClaw would discover automatically.
- Hermes SQLite is the canonical historical session store.
- Grouping by Hermes `source` keeps the integration low-risk and reviewable in DataClaw’s existing project-selection UX.

## Follow-up improvements

Good next iterations would be:

1. preserve Hermes lineage metadata when DataClaw has a clean place for it
2. improve tool/result reconstruction for more Hermes message variants
3. optionally support transcript fallback from `~/.hermes/sessions/`
4. revisit grouping if a stronger project/workspace concept emerges in Hermes metadata
