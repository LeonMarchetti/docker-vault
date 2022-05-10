FROM alpine:latest

RUN apk add --update --no-cache curl openssh sudo vault \
    && adduser -D ubuntu  \
    && echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu
