pid_file = "/etc/vault.d/agent/pidfile"

vault {
    address = "http://localhost:8200"
}

auto_auth {
    method {
        type = "approle"
        config = {
            role_id_file_path = "/etc/vault.d/agent/roleid"
            secret_id_file_path = "/etc/vault.d/agent/secretid"
            remove_secret_id_file_after_reading = false
        }
    }

    sink {
        type = "file"
        config = {
            path = "/etc/vault.d/agent/sink"
        }
    }
}

cache {
    use_auto_auth_token = true
}

template_config {
    static_secret_render_interval = "30s"
}

# vault kv get kv/my_secret (version 2)
template {
    contents = "{{ with secret \"kv/data/my_secret\" }}{{ .Data.data.value }}{{ end }}"
    destination = "/etc/vault.d/agent/example.txt"
}
