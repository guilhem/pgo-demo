FROM golang:1.23 AS builder
WORKDIR /go/src/app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o /go/bin/app -ldflags="-extldflags=-static -linkmode 'external'" .

FROM alpine:3.14
COPY --chown=65534:65534 --from=builder /go/bin/app /usr/local/bin/app
USER 65534

ENTRYPOINT [ "/usr/local/bin/app" ]
