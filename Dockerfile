FROM dart
WORKDIR /
RUN rm -rf /dart_api
RUN mkdir dart_api
COPY . /dart_api
CMD /dart_api/dart.sh
