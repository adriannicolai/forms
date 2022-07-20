FROM ruby:3.1.1
FROM alpine:3.14

RUN apk update && apk add \
mysql-dev \
ruby ruby-dev ruby-bundler ruby-irb ruby-json ruby-rake ruby-bigdecimal \
nodejs yarn tzdata