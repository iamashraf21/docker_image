FROM ubuntu:latest

FROM python:3

RUN apt-get update && \
      apt-get -y install sudo
RUN apt-get install curl
RUN useradd -ms '/bin/bash' docker && echo "docker:docker" | chpasswd && adduser docker sudo

#RUN adduser --disabled-password --gecos '' docker
#RUN adduser docker sudo
#RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

RUN echo "# arduino-cli.yaml \n\
board_manager: \n\
  additional_urls: \n\
    - https://lowpowerlab.github.io/MoteinoCore/package_LowPowerLab_index.json" > arduino-cli.yaml

RUN arduino-cli core update-index

#USER docker
#RUN sudo usermod -aG sudo docker
#RUN sudo usermod -a -G dialout docker
#RUN sudo usermod -d /home/docker docker

RUN chown -R docker /home/docker
WORKDIR /home/docker
RUN python -m pip install pyserial

RUN python -m pip install xmlformatter

#RUN arduino-cli lib install micro-ecc
RUN arduino-cli core install Moteino:samd
