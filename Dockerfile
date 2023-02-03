### helper builder image (for tdlib build) ###
FROM dart:stable as builder

# Install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cmake build-essential gperf libssl-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

# get version 1.8.0 and compile
RUN rm -rf td && \
    git clone https://github.com/tdlib/td.git && \
    cd td && \
    git checkout v1.8.0 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    cmake --build . && \
    make install

#############

### main application image ###
FROM dart:stable

# Copy tdlib binaries
COPY --from=builder /td/build /usr/local/lib/

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
    "--libtdjson-path=","$PATH_TD_JSON_LIB","--libtdjson-loglevel=","$LOG_LEVEL", \
    "--database-path=", "$PATH_TD_JSON_LIB_DATA", \
    "--message-database-path", "$PATH_DB_MESSAGE"]
