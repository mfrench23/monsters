FROM starefossen/ruby-node:alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

EXPOSE 3000
CMD ["bin/spring", "rails", "server", "-b", "0.0.0.0"]

RUN apk update && apk upgrade

RUN apk add --no-cache --update \
    build-base \
    linux-headers \
    mysql-client \
    tzdata \
    graphviz \
    gmp-dev \
    yarn \
    ruby-nokogiri \
    mariadb-dev

COPY Gemfile /usr/src/app/

RUN gem install bundler
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . /usr/src/app

