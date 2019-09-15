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

#RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
#RUN apt-get update && apt remove cmdtest && apt-get install -y yarn --no-install-recommends && rm -rf /var/lib/apt/lists/*
#RUN apt-get update && apt-get install -y default-mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY Gemfile /usr/src/app/

RUN gem install bundler
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . /usr/src/app

