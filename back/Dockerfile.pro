FROM ruby:3.0.2-alpine3.13

ARG WORKDIR

ARG RAILS_MASTER_KEY

ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git imagemagick" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY Gemfile* ./

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_PACKAGES} && \
    apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
    bundle install --jobs=4 --retry=3 && \
    apk del build-dependencies

COPY . .

EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]