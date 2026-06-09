#!/usr/bin/env bash
set -euo pipefail

# Run from the project root
cd "$(dirname "$0")/.."

OUTPUT="dbt-airstats-solutions.zip"

rm -f "$OUTPUT"

zip -r "$OUTPUT" . \
  --exclude "*.claude*" \
  --exclude "CLAUDE.md" \
  --exclude "./.dev/*" \
  --exclude "./.venv/*" \
  --exclude "./airstats/.venv/*" \
  --exclude "./airstats/target/*" \
  --exclude "./airstats/logs/*" \
  --exclude "./airstats/dbt_packages/*" \
  --exclude "./airstats/dbt_internal_packages/*" \
  --exclude "./airstats/node_modules/*" \
  --exclude "*/profiles.yml" \
  --exclude ".git/*" \
  --exclude ".gitignore" \
  --exclude ".gitattributes" \
  --exclude "__pycache__/*" \
  --exclude "*.pyc"

echo "Created: $OUTPUT"
