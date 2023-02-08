### helper builder image (for tdlib build) ###
FROM dart:stable as builder

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cmake build-essential gperf libssl-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN rm -rf /app-temp && mkdir -p /app-temp
COPY ./packages/td_json_client/lib/src/log_callback /app-temp/packages/td_json_client/lib/src/log_callback

WORKDIR /app-temp

RUN \
    rm -rf packages/td_json_client/build && \
    mkdir packages/td_json_client/build && \
    cd packages/td_json_client/build && \
    rm -rf /app-temp/packages/td_json_client/lib/src/blobs/linux/* && \
    cmake \
        -DCMAKE_INSTALL_PREFIX:PATH=/app-temp/packages/td_json_client/lib/src/blobs/linux \
        /app-temp/packages/td_json_client/lib/src/log_callback && \
    cmake --build . --target install

### main application image ###
FROM dart:stable

# Install packages
RUN apt update \
    && apt install -y \
    libc++-dev libsqlite3-dev procps \
    && rm -rf /var/lib/apt/lists/*

# Copy tdlib binaries
COPY --from=builder /app-temp/packages/td_json_client/lib/src/blobs/linux/libtdjsonlc.so  /usr/local/lib/
COPY --from=builder /app-temp/packages/td_json_client/lib/src/blobs/linux/lib/libtdjson.so*  /usr/local/lib/
RUN ldconfig

RUN rm -rf /app-temp

RUN rm -rf /app && mkdir -p /app
COPY melos.yaml melos.yaml
COPY ./packages /app/packages

ENV PATH="/root/.pub-cache/bin:${PATH}"

WORKDIR /app

RUN dart pub global activate melos

RUN melos bootstrap 

CMD ["sh", "-c", "/app/packages/cli/bin/main.sh"]
