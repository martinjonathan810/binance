FROM ruby:3.0.0-alpine

RUN apk add --update --no-cache binutils-gold build-base curl file g++ gcc git less libstdc++ libffi-dev libc-dev linux-headers libxml2-dev libxslt-dev libgcrypt-dev sqlite-libs sqlite-dev make netcat-openbsd nodejs pkgconfig tzdata yarn

RUN gem install bundler:2.2.3

WORKDIR /binance

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --binstubs

COPY yarn.lock package.json ./

RUN yarn install --check-files

COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]