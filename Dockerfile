FROM dart:stable
WORKDIR /
RUN rm -rf /dart_api
ARG USERNAME=root
ENV PATH="${PATH}:/${USERNAME}/.pub-cache/bin"
RUN mkdir dart_api && mkdir dart_api/sl_td_lib
COPY . /dart_api
#COPY env.local /dart_api/sl/packages/sl_cli/.env
#ADD env.local /dart_api/sl/packages/sl_cli/.env
RUN chmod +x /dart_api/dart.sh
CMD /dart_api/dart.sh
#CMD tail -f /dev/null
