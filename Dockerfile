FROM ruby:2.7.1-slim

# Set locale
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US:en

RUN apt-get update -qq \
    && apt-get install -qq -y locales \
    && rm -rf /var/lib/apt/lists/* \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/default/locale \
    && locale-gen

# Minimal requirements to run a Rails app
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential \
      libpq-dev \
      git \
      tzdata \
      libxml2-dev \
      libxslt-dev \
      curl \
      gnupg \
      cron \
      ssh && rm -rf /var/lib/apt/lists/*

ENV APP_NAME /url_shortener
RUN mkdir /$APP_NAME
WORKDIR /$APP_NAME

COPY Gemfile* $APP_NAME/

ENV BUNDLE_PATH=/bundle \
    BUNDLE_JOBS=3 \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN bundle install

COPY . /$APP_NAME
