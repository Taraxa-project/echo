### helper builder image (for tdlib build) ###
FROM dart:3.1.4 as builder

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
COPY pubspec.yaml pubspec.yaml
COPY chats_new.csv chats_new.csv
COPY ./packages /app/packages

ENV PATH="/root/.pub-cache/bin:${PATH}"


RUN dart pub global activate melos

RUN melos bootstrap 

RUN dart compile exe packages/cli/bin/main.dart --output=echo
RUN dart compile exe packages/cli/tool/scripts/check_groups_captcha.dart --output=echo_check_groups_captcha
RUN dart compile exe packages/cli/tool/scripts/reports.dart --output=reports

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
COPY --from=builder /app/packages/cli/bin/check_groups_captcha.sh /app/

# Copy compiled executables
COPY --from=builder /app/echo /app/echo
COPY --from=builder /app/echo_check_groups_captcha /app/echo_check_groups_captcha
COPY --from=builder /app/chats_new.csv /app/chats_new.csv
COPY --from=builder /app/reports /app/reports

CMD ["sh", "-c", "/app/main.sh"]
