FROM rust:1.85.0-alpine AS builder

RUN apk add musl-dev

WORKDIR /app
COPY codegen codegen
COPY Cargo.toml ./
COPY crates crates 
RUN cargo build --release --features=binary --bin s3s-fs

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/target/release/s3s-fs .

ENTRYPOINT ["./s3s-fs"]

