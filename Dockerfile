ARG GO_VERSION=1.22.1
ARG GOOSE_VERSION=3.19.2

FROM golang:${GO_VERSION}-alpine as build

ARG GOOSE_VERSION

WORKDIR /build
RUN wget https://github.com/pressly/goose/archive/refs/tags/v${GOOSE_VERSION}.tar.gz \
    && tar zxf v${GOOSE_VERSION}.tar.gz
WORKDIR /build/goose-${GOOSE_VERSION}
RUN go mod tidy
RUN go build \
    -ldflags="-s -w" \
    -tags='no_postgres no_sqlite3 no_mssql no_mysql no_libsql no_vertica no_ydb' \
    -o ../goose ./cmd/goose

FROM oraclelinux:9

COPY --from=build /build/goose /usr/bin/goose
WORKDIR /goose
COPY sql ./sql
COPY migrate.sh .