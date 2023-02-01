### helper builder image (for tdlib build) ###
FROM dart:stable as builder

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cmake build-essential gperf libssl-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN rm -rf /app-temp && mkdir -p /app-temp
COPY . /app-temp

WORKDIR /app-temp

RUN rm -rf packages/td_json_client/build && \
 mkdir packages/td_json_client/build && \
 cd packages/td_json_client/build && \
 cmake -DCMAKE_INSTALL_PREFIX:PATH=/app-temp/linux_build /app-temp/packages/td_json_client/lib/src/log_callback && \
 cmake --build . --target install

### main application image ###
FROM dart:stable

# Copy tdlib binaries
COPY --from=builder /app-temp/linux_build  /usr/local/lib/

RUN rm -rf /app-temp

# Install packages
RUN apt update \
    && apt install -y \
    libc++-dev \
    && rm -rf /var/lib/apt/lists/*

RUN rm -rf /app && mkdir -p /app
COPY . /app

ENV PATH="/root/.pub-cache/bin:${PATH}"

WORKDIR /app

RUN dart pub global activate melos

RUN melos bootstrap 
RUN melos run get

ENTRYPOINT [ "/usr/lib/dart/bin/dart", "run"]

CMD ["/app/packages/cli/bin/main.dart","login","-h","--api-id=","$API_ID", \
    "--api-hash=","$API_HASH","--phone-number=","$PHONE", \
    "--libtdjson-path=","$PATH_TD_JSON_LIB","--loglevel=", "$LOG_LEVEL","--libtdjson-loglevel=","$LIBTDJSON_LOGLEVEL", \
    "--database-path=", "$DATABASE_PATH", "--message-database-path=", "$DATABASE_PATH/message.sqlite messages", "--chat-names=", "$CHAT_NAMES", \
    "--run-forever=", "$RUN_FOREVER"]
