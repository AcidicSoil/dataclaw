# Suggested commands for DataClaw

## Environment / repository
- `ls`
- `find . -maxdepth 2 -type f | sort`
- `git status`
- `git diff`

## Install
- `pip install -e .`
- `pip install -e .[dev]`

## Tests
- `pytest`
- `pytest tests/test_parser.py`
- `pytest tests/test_cli.py`

## Packaging / entrypoint
- `python -m dataclaw.cli --help`
- `dataclaw status`

## Product-specific commands
- `dataclaw prep`
- `dataclaw list`
- `dataclaw config --source all`
- `dataclaw export --no-push`
- `dataclaw confirm --skip-full-name-scan --attest-full-name "..." --attest-sensitive "..." --attest-manual-scan "..."`
- `dataclaw export --publish-attestation "User explicitly approved publishing to Hugging Face."`

## Hugging Face auth
- `huggingface-cli login --token <TOKEN>`

Note: README/AGENTS explicitly warn never to run bare `huggingface-cli login` without `--token` because it is interactive and may hang.