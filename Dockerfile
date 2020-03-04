FROM golang:1.14.0-buster as build

RUN apt-get update && apt-get install xz-utils

ENV UPX_VERSION="3.96"
RUN wget https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz && tar -xf upx-${UPX_VERSION}-amd64_linux.tar.xz &&  mv upx-${UPX_VERSION}-amd64_linux/upx /usr/local/bin/ && rm -rf upx*

RUN go get -u github.com/mitchellh/gox

FROM golang:1.14-stretch

COPY --from=build /usr/local/bin/upx /usr/local/bin/upx
COPY --from=build /go/bin/gox /usr/local/bin/gox

ENV CGO_ENABLED=0