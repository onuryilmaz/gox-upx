ARG GOVERSION=1.20
ARG DISTRO=stretch
FROM golang:${GOVERSION}-${DISTRO} as build

RUN apt-get update && apt-get install xz-utils

ARG UPX_VERSION="4.1.0"
ENV UPX_VERSION=${UPX_VERSION}
RUN wget https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz && tar -xf upx-${UPX_VERSION}-amd64_linux.tar.xz &&  mv upx-${UPX_VERSION}-amd64_linux/upx /usr/local/bin/ && rm -rf upx*

RUN go install github.com/mitchellh/gox@latest

FROM golang:${GOVERSION}-${DISTRO}

COPY --from=build /usr/local/bin/upx /usr/local/bin/upx
COPY --from=build /go/bin/gox /usr/local/bin/gox

ENV CGO_ENABLED=0
