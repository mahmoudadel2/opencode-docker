#!/bin/sh
set -eu

if ! pgrep -x ollama >/dev/null 2>&1; then
  nohup ollama serve >/tmp/ollama.log 2>&1 &
fi

for i in $(seq 1 60); do
  if curl -fsS http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

if ! ollama list 2>/dev/null | grep -qi 'zerocopia/qwen3-coder-next:cloud'; then
  ollama pull zerocopia/qwen3-coder-next:cloud
fi

mkdir -p /root/.config/opencode
cat >/root/.config/opencode/opencode.json <<'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (local)",
      "options": {
        "baseURL": "http://127.0.0.1:11434/v1"
      },
      "models": {
        "zerocopia/qwen3-coder-next:cloud": {
          "name": "Qwen3 Coder Next Cloud"
        }
      }
    }
  },
  "model": "ollama/zerocopia/qwen3-coder-next:cloud"
}
EOF

exec opencode "$@"
