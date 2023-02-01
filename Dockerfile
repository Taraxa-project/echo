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
 cmake -DCMAKE_INSTALL_PREFIX:PATH=/app-temp/packages/td_json_client/lib/src/blobs/darwin/arm64 /app-temp/packages/td_json_client/lib/src/log_callback && \
 cmake --build . --target install

### main application image ###
FROM dart:stable

# Copy tdlib binaries
COPY --from=builder /app-temp/packages/td_json_client/lib/src/blobs/darwin/arm64 /usr/local/lib/

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

# issue running melos bootstrap because of a Null check operator used on a null value when subspec is loading a file, (package:pubspec/src/pubspec.dart:128:15)
RUN melos bootstrap 
RUN melos run get

ENTRYPOINT [ "/usr/lib/dart/bin/dart", "run"]
# # with modified libtdjson-path to be LIB_TD_JSON_PATH="/usr/local/lib/libtdjsonlc.dylib"

CMD ["/app/packages/cli/bin/main.dart","login","-h","--api-id=","$API_ID", \
    "--api-hash=","$API_HASH","--phone-number=","$PHONE", \
    "--libtdjson-path=","$PATH_TD_JSON_LIB","--libtdjson-loglevel=","$LOG_LEVEL"]
