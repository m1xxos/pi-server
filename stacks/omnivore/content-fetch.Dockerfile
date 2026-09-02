# The upstream parser aborts every request past the 100th and waits only 30s for
# the `load` event. Heavy SPAs blow through that cap — habr.com issues 300+
# requests — so the assets `load` depends on get killed and page.goto() always
# fails with "Navigation timeout of 30000 ms exceeded".
FROM ghcr.io/omnivore-app/sh-content-fetch:latest

ARG PARSER=/app/packages/puppeteer-parse/build/src/index.js

# Fail the build instead of silently shipping an unpatched image if upstream
# ever reworks these lines.
RUN set -eu; \
    grep -q 'requestCount++ > 100' "$PARSER"; \
    grep -q 'timeout: 30 \* 1000' "$PARSER"; \
    sed -i \
      -e 's/requestCount++ > 100/requestCount++ > 1000/' \
      -e 's/timeout: 30 \* 1000/timeout: 60 * 1000/' \
      -e "s/for 30 seconds/for 60 seconds/" \
      "$PARSER"
