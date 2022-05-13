FROM vault:latest

ENTRYPOINT ["vault", "server", "-config", "/etc/vault.d/config.hcl"]
