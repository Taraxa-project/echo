FROM dart
WORKDIR /
RUN rm -rf /dart_api
RUN mkdir dart_api
# RUN git clone https://github.com/periodicaidan/dart_tdlib && cd dart_tdlib
COPY . /dart_api

#FROM wcsiu/tdlib:latest
#WORKDIR /usr/local/lib/
#COPY . /dart_api/lib/
CMD /dart_api/dart.sh
