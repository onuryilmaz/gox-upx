FROM golang:1.14-alpine

ARG UPX_VERSION "3.96"
RUN wget https://github.com/upx/upx/releases/download/v${UPX_VERSION}/upx-${UPX_VERSION}-amd64_linux.tar.xz
RUN tar -xf upx-${UPX_VERSION}-amd64_linux.tar.xz && mv upx-${UPX_VERSION}-amd64_linux/upx /usr/local/bin/ && rm -rf upx*

RUN go get -u github.com/mitchellh/gox

ENV CGO_ENABLED=0