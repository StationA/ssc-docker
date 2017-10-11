FROM alpine:3.6 as build

# Update and install deps

RUN apk update

RUN apk add --no-cache \
    ca-certificates \
    curl \
    git \
    wget \
    zip \
    build-base \
    bash

WORKDIR /tmp

ADD install_ssc.sh install_ssc.sh

RUN ./install_ssc.sh

FROM alpine:3.6

COPY --from=build /usr/local/lib/libssc.so /usr/local/lib/libssc.so
COPY --from=build /usr/local/include/sscapi.h /usr/local/include/sscapi.h

RUN apk update
