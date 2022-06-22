### helper builder image (for tdlib build) ###
FROM dart:stable as builder

# Install packages
RUN apt update \
    && apt install -y \
    make \
    git \
    zlib1g-dev \
    libssl-dev \
    gperf \
    php-cli \
    cmake \
    clang \
    libc++-dev \
    libc++abi-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/tdlib/td.git /tmp/td \
    && mkdir -p /tmp/td/build && cd /tmp/td && git checkout v1.8.0

ENV CXXFLAGS="-stdlib=libc++"
ENV CC="/usr/bin/clang"
ENV CXX="/usr/bin/clang++"

WORKDIR /tmp/td/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib ..

# compile
RUN cmake --build . --target install

#############

### main application image ###
FROM dart:stable

# Copy tdlib binaries
COPY --from=builder /tmp/td/tdlib/include /usr/local/include/
COPY --from=builder /tmp/td/tdlib/lib /usr/local/lib/

# Install packages
RUN apt update \
    && apt install -y \
    libc++-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/dart_api
COPY sl /app/dart_api

ENV PATH="/root/.pub-cache/bin:${PATH}"

WORKDIR /app/dart_api/packages

RUN dart pub global activate melos

RUN melos bootstrap
RUN melos run get

ENTRYPOINT [ "/usr/lib/dart/bin/dart", "run"]
CMD ["/app/dart_api/packages/sl_cli/main.dart"]
