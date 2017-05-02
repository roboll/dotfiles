FROM debian:jessie

RUN useradd roboll
RUN apt-get update && apt-get install -y sudo
RUN echo "roboll	ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/roboll

USER roboll
WORKDIR /home/roboll

ENV USER=roboll
ENV BOXNAME=kit
ENV SKIP_CONFIRM=true

ADD . .dotfiles
RUN sudo chown roboll:roboll /home/roboll && .dotfiles/install.sh

ENTRYPOINT ["/bin/bash"]