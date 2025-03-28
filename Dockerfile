FROM golang:1.23.1 AS build

WORKDIR /app

COPY . .

RUN go build -o chronoverseapi cmd/app/main.go

FROM alpine:3.20.2

RUN apk add --no-cache tzdata

ENV TZ=UTC

RUN apk add --no-cache libc6-compat

WORKDIR /app

COPY --from=build /app/chronoverseapi /app/chronoverseapi

CMD ["/app/chronoverseapi"]
