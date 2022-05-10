FROM rastasheep/ubuntu-sshd

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  \
    && apt-get install -y unzip sudo \
    && mkdir -p /etc/vault-ssh-helper.d \
    && mkdir -p /usr/local/bin

RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /usr/local/bin

RUN wget https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip \
  -O tmp.zip && unzip tmp.zip && rm tmp.zip

COPY ssh_helper/config.hcl /etc/vault-ssh-helper.d/
COPY ssh_helper/sshd /etc/pam.d/
COPY ssh_helper/sshd_config /etc/ssh/sshd_config

#RUN sed -i "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g" /etc/ssh/sshd_config

#RUN sed -i "s/^#UsePAM yes/UsePAM yes/g" /etc/ssh/sshd_config

#RUN sed -i "s/\#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config

RUN useradd -ms /bin/bash ubuntu -g sudo
RUN useradd -ms /bin/bash debian -g sudo

CMD ["/usr/sbin/sshd", "-D"]
