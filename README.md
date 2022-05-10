# Secretos Dinámicos con Vault

## Setup

1. Arrancar contenedores: `docker-compose up --build --force-recreate
2. Ir a interfaz web: `localhost:8200/ui` y seguir los pasos para abrir la bóveda e iniciar sesión con el token de root.

### Habilitar SSH OTP desde la interfaz web

1. Ir a **Enable new engine...**
2. Elegir **SSH** y dar a **Next**
3. Elegir nombre del motor (dejar **ssh** por defecto) y dar a **Enable Engine**
4. Ir a **Create role**
5. Escribir **otp_role_ubuntu** en **Role name**, selecionar **otp** en **Key type**
    > Elegir un nombre de rol habilitado en `ssh_helper/config.hcl`, dentro de `allowed_roles`

    > Es el nombre de usuario que usa vault si no se escribe en `vault write ssh/...`, si se hace desde una terminal

6. Desplegar **Options** y escribir la red con máscara en **CIDR List** y dar a **Create role**
    > Puedo usar `docker network inspect docker_vault_default` para ver la Subnet para colocar en **CIDR List**

7. Ir a **Generate Credential**
8. Escribir nombre de usuario del sistema en **Username** y dirección IP en **IP Address** y dar a **Generate**
    > Puedo usar `docker network inspect docker_vault_default` para ver las direcciones IP de los contenedores

    > El nombre de usuario puede otro a parte del definido en **Default Username**

9. Copiar clave de SSH en **Key**. Se puede usar el botón de copiar para mantenerlo oculto y copiarlo al portapapeles.

### Habilitar logs

Desde una terminal, con token de root, ejecutar: `audit enable file file_path=/var/log/vault/vault_audit.log format=json`.

Los logs se guardan en `./volumes/logs`.

> Por alguna razón no pude hacerlo desde la interfaz web.

## Acerca

Saqué el `Dockerfile` de `vault_ssh_helper` de [erryg/docker-vault-ssh-helper](https://github.com/errygg/docker-vault-ssh-helper), con modificaciones para cambiar los volúmenes y los usuarios creados.