FROM ghcr.io/anomalyco/opencode:latest

ENV OLLAMA_HOST=0.0.0.0 \
    OLLAMA_ORIGINS="*" \
    OPENAI_API_KEY=ollama \
    OPENAI_BASE_URL=http://127.0.0.1:11434/v1 \
    OPENAI_MODEL=zerocopia/qwen3-coder-next:cloud \
    OPENCODE_MODEL=zerocopia/qwen3-coder-next:cloud \
    HOME=/root

RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    procps \
    zstd \
    && rm -rf /var/cache/apk/* \
    && curl -fsSL https://ollama.com/install.sh | sh

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh \
    && mkdir -p /root/.config/opencode /workspace

WORKDIR /workspace
EXPOSE 3000 11434

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["serve"]
