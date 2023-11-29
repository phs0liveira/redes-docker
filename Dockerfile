FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server sudo vim iputils-ping && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/run/sshd

RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -ms /bin/bash docker && \
    echo 'docker:docker' | chpasswd && \
    adduser docker sudo

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
