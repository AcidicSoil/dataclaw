# What to do when a task is completed in DataClaw

- Run the most relevant pytest coverage for the touched area first:
  - parser changes -> `pytest tests/test_parser.py`
  - CLI/workflow/source selection changes -> `pytest tests/test_cli.py`
  - config changes -> `pytest tests/test_config.py`
- If the change is broad or touches multiple areas, run `pytest` for the full suite.
- Verify that any new source/support addition is reflected consistently across:
  - parser discovery
  - parser session parsing branch
  - CLI source-choice/help/status text
  - tests for parser and CLI behavior
  - README/AGENTS/docs when user-facing support matrix changes
- Do not claim validation unless the relevant tests were actually run.
- Preserve the staged workflow and `next_steps` behavior; this is a core product rule called out in README/AGENTS/docs.