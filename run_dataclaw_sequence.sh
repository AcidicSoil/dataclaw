#!/usr/bin/env bash

TARGET="$HOME/projects/temp/ai-apps/dataset-dashboard/raw-chat-data/dataclaw_export.jsonl"

mkdir -p "$(dirname "$TARGET")" &&
dataclaw prep &&
dataclaw config --source all &&
dataclaw list --source all &&
dataclaw config --repo acidicsoil/my-personal-codex-data &&
dataclaw export --no-push --output "$TARGET"