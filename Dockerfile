FROM alpine:3.7 as build

# Update and install deps

RUN apk update

RUN apk add --no-cache \
    ca-certificates \
    curl \
    wget \
    zip \
    build-base \
    bash

WORKDIR /tmp

ADD install_ssc.sh install_ssc.sh

RUN ./install_ssc.sh

FROM alpine:3.7

COPY --from=build /usr/lib/libssc.so /usr/local/lib/libssc.so
COPY --from=build /usr/include/sscapi.h /usr/local/include/sscapi.h

RUN apk update
