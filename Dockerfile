FROM frolvlad/alpine-glibc
MAINTAINER Israel Sotomayor <sotoisra24@gmail.com>

ENV FILEBEAT_VERSION=1.1.1 \
    FILEBEAT_SRC_SHA1=05f99d2f61fee1608d01f583a2d0737a53bbd4b5

RUN set -ex \
  && apk --no-cache add --virtual .build-dependencies \
    curl \
  \
  && curl -fsSL http://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz -o /tmp/filebeat.tar.gz \
  \
  && cd /tmp \
  && echo "${FILEBEAT_SRC_SHA1} *filebeat.tar.gz" | sha1sum -c - \
  && tar -xzf filebeat.tar.gz \
  \
  && cd filebeat-* \
  && cp filebeat /bin \
  \
  && rm -rf /tmp/filebeat* \
  && apk del .build-dependencies

CMD [ "filebeat", "-e" ]
