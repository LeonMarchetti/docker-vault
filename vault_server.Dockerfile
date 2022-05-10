FROM vault:latest

RUN mkdir -p /opt/vault/data

ENTRYPOINT ["vault", "server", "-config", "/etc/vault.d/config.hcl"]
