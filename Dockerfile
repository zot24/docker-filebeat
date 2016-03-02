FROM alpine:3.3
MAINTAINER Israel Sotomayor <sotoisra24@gmail.com>

ENV FILEBEAT_VERSION=filebeat-1.1.1-x86_64 \
    TMP_DIR=/tmp

WORKDIR $TMP_DIR
RUN apk --no-cache add --virtual build-dependencies \
    curl \
  && curl -sSL http://download.elastic.co/beats/filebeat/${FILEBEAT_VERSION}.tar.gz | tar -xz \
  && cd $TMP_DIR/$FILEBEAT_VERSION \
  && cp filebeat /bin \
  && rm -rf $TMP_DIR/$FILEBEAT_VERSION \
  && apk del build-dependencies \
  && rm -rf ~/.cache

CMD [ "filebeat", "-e" ]
