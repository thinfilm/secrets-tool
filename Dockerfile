# Compile backend
FROM golang:alpine as app

RUN apk --no-cache add ca-certificates git
RUN mkdir -p /go/src/github.com/thinfilm/secrets-tool
WORKDIR /go/src/github.com/thinfilm/secrets-tool
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep && dep ensure
WORKDIR /go/src/github.com/thinfilm/secrets-tool/server
RUN go build

# Compile frontend
FROM node as website

WORKDIR /website
COPY website/ .
RUN yarn install && yarn build

# Using compiled backend and frontend for final image
FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=app /go/src/github.com/thinfilm/secrets-tool/server/server .
COPY --from=website /website/build /root/public
EXPOSE 1337
CMD ["./server"]
