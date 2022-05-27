FROM dart
WORKDIR /
RUN rm -rf /dart_api
# RUN git clone https://github.com/periodicaidan/dart_tdlib && cd dart_tdlib
COPY . /dart_api
RUN cd /dart_api && dart pub get && \
    dart run ./bin/main.dart
