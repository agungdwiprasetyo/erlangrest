# Build stage 0
FROM erlang:alpine

WORKDIR /usr/app
ENV SRC_DIR=/usr/app/

# Copy our Erlang application
COPY . $SRC_DIR

# And build the release
RUN rebar3 as prod release

# Build stage 1
FROM alpine

# Install some libs
RUN apk add --no-cache openssl && \
    apk add --no-cache ncurses-libs

# Install the released application
COPY --from=0 /usr/app/_build/prod/rel/erlangrest /

# Expose relevant ports
EXPOSE 4000

CMD ["/bin/erlangrest", "foreground"]
