FROM dart
WORKDIR /
RUN apt-get update && apt-get install git
RUN rm -rf /dart_tdlib
RUN git clone https://github.com/periodicaidan/dart_tdlib && cd dart_tdlib
