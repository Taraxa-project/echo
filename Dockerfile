### helper builder image (for tdlib build) ###
FROM dart:stable as builder

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cmake build-essential gperf libssl-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app-temp
COPY ./packages/td_json_client/lib/src/log_callback/ /app-temp/

WORKDIR /app-temp/build

RUN \
    cmake \
        -DCMAKE_INSTALL_PREFIX:PATH=/app-temp \
        /app-temp && \
    cmake --build . --target install

# Copy Dart application and compile as an executable
WORKDIR /app
COPY melos.yaml melos.yaml
COPY ./packages /app/packages

ENV PATH="/root/.pub-cache/bin:${PATH}"


RUN dart pub global activate melos

RUN melos bootstrap 

RUN dart compile exe packages/cli/bin/main.dart --output=echo

### main application image ###
FROM dart:stable

# Install packages
RUN apt update \
    && apt install -y \
    libc++-dev libsqlite3-dev procps \
    && rm -rf /var/lib/apt/lists/*

# Copy tdlib binaries
COPY --from=builder /app-temp/libtdjsonlc.so  /usr/local/lib/
COPY --from=builder /app-temp/lib/libtdjson.so*  /usr/local/lib/
RUN ldconfig

COPY --from=builder /app/packages/cli/bin/main.sh /app/

# Copy compiled executable
COPY --from=builder /app/echo /app/echo

CMD ["sh", "-c", "/app/main.sh"]
