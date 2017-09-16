FROM ruby:2.4.1-alpine as builder

RUN apk --update add --virtual build-dependencies build-base curl-dev linux-headers git
RUN echo 'gem: --no-document' > /etc/gemrc

WORKDIR /app
ADD . /app
RUN bundle install --jobs=4 --without development test
RUN apk del build-dependencies


FROM ruby:2.4.1-alpine

ENV LANG ja_JP.UTF-8
RUN apk --update add git
COPY --from=builder /usr/local/bundle /usr/local/bundle

ADD . /app
RUN chown -R nobody:nogroup /app
USER nobody

WORKDIR /app
