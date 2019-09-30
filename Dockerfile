# chromium > 76 is required. For now, this is only available in the 'edge' build
FROM alpine:edge

# Install chromium, some dependnecies, node and dumb-init
RUN apk add --no-cache \
      chromium nss freetype freetype-dev harfbuzz ca-certificates ttf-freefont \
      nodejs npm \
      dumb-init

# Add user so we don't need --no-sandbox.
RUN addgroup -S chromium &&\
    adduser -S -g chromium chromium &&\
    mkdir /app &&\
    chown -R chromium:chromium /app

# Run everything after as non-privileged user.
USER chromium

# Set CHROME_BIN to avoid tweaking config files (e.g. karma.conf.js)
ENV CHROME_BIN=/usr/bin/chromium-browser

WORKDIR /app

# dumb-init avoids having zombie Chrome processes
ENTRYPOINT ["/usr/bin/dumb-init", "--"]