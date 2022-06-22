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
#COPY --from=builder /td/tdlib/include /usr/local/include/
COPY --from=builder /td/build /usr/local/lib/

# Install packages
RUN apt update \
    && apt install -y \
    libc++-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/dart_api
COPY . /app/dart_api

ENV PATH="/root/.pub-cache/bin:${PATH}"

WORKDIR /app/dart_api/packages

RUN dart pub global activate melos

RUN melos bootstrap
RUN melos run get

ENTRYPOINT [ "/usr/lib/dart/bin/dart", "run"]
CMD ["/app/dart_api/packages/cli/bin/main.dart"]
