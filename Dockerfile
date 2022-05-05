# syntax=docker/dockerfile:1

FROM golang:1.16-alpine

ARG IMAGE_TAG=untagged
ENV IMAGE_TAG=${IMAGE_TAG}

WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN go build -o /server

CMD [ "/server" ]