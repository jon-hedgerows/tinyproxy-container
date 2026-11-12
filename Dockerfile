FROM alpine:3.24.4 AS tinyproxy

RUN apk update && apk add tinyproxy && apk add curl && rm -rf /var/cache/apk/* && rm -f /var/log/apk.log

COPY ./src/run.sh /run.sh
COPY ./src/healthcheck.sh /healthcheck.sh

VOLUME /conf
EXPOSE 8888

HEALTHCHECK \
  --interval=30s --timeout=5s --start-period=30s --start-interval=5s --retries=1 \
  CMD /healthcheck.sh

CMD [ "/run.sh" ]
