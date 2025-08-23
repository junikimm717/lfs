FROM alpine:latest AS builder

WORKDIR /workspace
RUN apk add --no-cache go
COPY . /workspace
RUN go build .

FROM alpine:latest
COPY --from=builder /workspace/monitor /monitor
WORKDIR /workspace
ENTRYPOINT ["/monitor", "serve", "-P", "80", "-S", "/workspace/save.json"]
EXPOSE 80
