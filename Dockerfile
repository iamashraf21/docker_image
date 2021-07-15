FROM ubuntu:latest

FROM python:3

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN apt-get update && \
      apt-get -y install sudo
RUN apt-get install curl
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
USER docker
WORKDIR /home/dokcer

RUN python -m pip install pyserial

RUN python -m pip install xmlformatter

RUN echo "# arduino-cli.yaml \n\
board_manager: \n\
  additional_urls: \n\
    - https://lowpowerlab.github.io/MoteinoCore/package_LowPowerLab_index.json" > arduino-cli.yaml

RUN arduino-cli lib install micro-ecc
RUN arduino-cli core update-index
RUN arduino-cli core install Moteino:samd
RUN usermod -a -G dialout docker
