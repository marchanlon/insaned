FROM gcc:bullseye AS insaned

ENV APP_DIR=/app
WORKDIR "$APP_DIR"

COPY Makefile "$APP_DIR/"
COPY src "$APP_DIR/src"

RUN apt-get update \
  && apt-get install -yq \
    libsane-dev \
  && rm -rf /var/lib/apt/lists/*;

RUN make

RUN apt-get update \
  && apt-get install -yq \
    sane \
    sane-utils \
    sane-airscan \
    ipp-usb \
  && rm -rf /var/lib/apt/lists/*;
