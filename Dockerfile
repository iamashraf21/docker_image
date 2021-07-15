FROM ubuntu:latest

FROM python:3

RUN apt-get update && \
      apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
USER docker
WORKDIR /home/dokcer

RUN docker apt-get install curl

RUN docker python -m pip install pyserial

RUN python -m pip install xmlformatter
