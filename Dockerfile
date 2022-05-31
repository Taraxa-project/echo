FROM dart
WORKDIR /
RUN rm -rf /dart_api
RUN su root
RUN mkdir dart_api && mkdir dart_api/lib
COPY . /dart_api
RUN chmod +x /dart_api/dart.sh
CMD /dart_api/dart.sh
