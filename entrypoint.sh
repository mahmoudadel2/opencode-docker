#!/bin/sh
set -eu

for i in $(seq 1 120); do
  if curl -fsS http://ollama:11434/api/tags >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

mkdir -p /root/.config/opencode
cat >/root/.config/opencode/opencode.json <<'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (local)",
      "options": {
        "baseURL": "http://ollama:11434/v1"
      },
      "models": {
        "qwen2.5-coder:7b": {
          "name": "Qwen2.5 Coder 7B"
        }
      }
    }
  },
  "model": "ollama/qwen2.5-coder:7b"
}
EOF

exec opencode "$@"
