# DataClaw project overview

- Purpose: CLI tool to export coding-agent conversation history to Hugging Face as structured datasets, with redaction/anonymization and staged review before publish.
- Status/packaging: Python package `dataclaw` (version 0.3.2 in `pyproject.toml`) with console entrypoint `dataclaw = dataclaw.cli:main`.
- Main stack: Python 3.10+ with setuptools packaging; runtime dependency `huggingface_hub`; tests use `pytest`.
- Repository layout:
  - `dataclaw/cli.py`: CLI surface, staged workflow, source selection, publish/review gating, JSON outputs.
  - `dataclaw/parser.py`: source discovery and per-source session parsing for Claude, Codex, Gemini, OpenCode, OpenClaw, Kimi, and custom imports.
  - `dataclaw/anonymizer.py`: path/user anonymization.
  - `dataclaw/secrets.py`: secret detection and redaction.
  - `dataclaw/config.py`: local config persistence and stage state.
  - `tests/`: focused pytest coverage for CLI, parser, config, anonymizer, and secret scanning.
  - `docs/SKILL.md` and `AGENTS.md`: operating guidance for agent-assisted use.
- Product behavior: staged flow is important (`auth -> configure -> review -> done/confirmed`), and README/AGENTS stress that every command emits `next_steps` that should be followed rather than improvising.