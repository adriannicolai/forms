# docker build --tag forms_clone .
# docker run -p 3000:3000 forms_clone
FROM ruby:3.1.1-alpine
RUN apk add --update --virtual \
    runtime-deps \
    mysql-dev \
    build-base \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    yarn \
    libffi-dev \
    readline \
    libc-dev \
    linux-headers \
    readline-dev \
    file \
    git \
    tzdata \
    sqlite-dev \
    && rm -rf /var/cache/apk/*

WORKDIR /server
COPY /server /server
ADD . /server/
ADD /server/Gemfile /codeapp/
ADD /server/Gemfile.lock /codeapp/

ENV BUNDLE_PATH /gems
RUN yarn install
RUN bundle install

ENTRYPOINT [ "bin/rails" ]
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000