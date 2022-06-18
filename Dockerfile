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
    && mkdir -p /tmp/td/build

ENV CXXFLAGS="-stdlib=libc++"
ENV CC="/usr/bin/clang"
ENV CXX="/usr/bin/clang++"

WORKDIR /tmp/td/build

RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=../tdlib ..

# compile
RUN cmake --build . --target install



### main application image ###
FROM dart:stable

# Copy tdlib binaries
COPY --from=builder /tmp/td/tdlib /usr/local/bin/tdlib



# ??????????????????????????????????????????
# WORKDIR /
# RUN rm -rf /dart_api
# ARG USERNAME=root
# ENV PATH="${PATH}:/${USERNAME}/.pub-cache/bin"
# RUN mkdir dart_api && mkdir dart_api/sl_td_lib
# COPY . /dart_api
# #COPY env.local /dart_api/sl/packages/sl_cli/.env
# #ADD env.local /dart_api/sl/packages/sl_cli/.env
# RUN chmod +x /dart_api/dart.sh
# CMD /dart_api/dart.sh
# #CMD tail -f /dev/null
# ??????????????????????????????????????????