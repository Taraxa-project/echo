FROM dart
WORKDIR /
RUN rm -rf /dart_tdlib /dart_api
# RUN git clone https://github.com/periodicaidan/dart_tdlib && cd dart_tdlib
VOLUME dart_api
COPY . /dart_api
