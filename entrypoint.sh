#!/bin/sh
set -eu

for i in $(seq 1 120); do
  if curl -fsS http://ollama:11434/api/tags >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

exec opencode "$@"
