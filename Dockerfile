# syntax=docker/dockerfile:1

FROM golang:1.16-alpine

ENV DUMMY_KEY=dummy_value

WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN go build -o /server

CMD [ "/server" ]