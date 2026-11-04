FROM ghcr.io/anomalyco/opencode:latest

ENV HOME=/root \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /workspace

RUN mkdir -p /root/.config/opencode/agents

COPY agents/* /root/.config/opencode/agents/
COPY opencode.json /root/.config/opencode/opencode.json

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh \
    && mkdir -p /root/.config/opencode /workspace \
    && apk update && apk add git python3 py3-virtualenv

EXPOSE 3000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["serve"]
