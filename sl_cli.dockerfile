FROM dart:stable AS build

WORKDIR /app

ARG USERNAME=root
ENV PATH="${PATH}:/${USERNAME}/.pub-cache/bin"

RUN dart --disable-analytics

COPY melos.yaml melos.yaml
COPY packages packages

RUN dart pub global activate melos
RUN melos bootstrap
