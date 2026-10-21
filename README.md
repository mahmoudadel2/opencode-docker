# opencode-docker

This repository provides a Docker image based on `ghcr.io/anomalyco/opencode` with a bundled local Ollama backend configured to use the `zerocopia/qwen3-coder-next:cloud` model.

## Features

- Uses the official `ghcr.io/anomalyco/opencode` image as the base.
- Installs Ollama inside the container.
- Starts Ollama automatically on container boot.
- Pulls and uses `zerocopia/qwen3-coder-next:cloud`.
- Configures OpenCode to connect to the local Ollama compatibility endpoint.

## Build

```bash
docker build -t opencode-docker .
```

## Run

```bash
docker run --rm -it \
  -p 3000:3000 \
  -p 11434:11434 \
  opencode-docker
```

This will start Ollama and OpenCode together. OpenCode is pointed at the local Ollama API at `http://127.0.0.1:11434/v1` and the model is set to `zerocopia/qwen3-coder-next:cloud`.

## Notes

- The container uses the OpenAI-compatible Ollama endpoint expected by OpenCode.
- If you want to use a different model, update `OPENAI_MODEL` and the `model` value in `/root/.config/opencode/opencode.json`.
- To keep the container running in a host-based environment, you can also run it as part of Docker Compose.
