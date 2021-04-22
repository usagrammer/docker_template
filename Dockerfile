FROM ruby:3.0.0

## updateしないとinstallできない
## updateの前2つやらないとyarnが古い
## imagemagickは最初から入ってる

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  build-essential \
  nodejs \
  yarn && \
  apt-get clean && \
  rm --recursive --force /var/lib/apt/lists/*

#作業ディレクトリを指定している mkdirは不要
ENV APP_PATH=/project
WORKDIR $APP_PATH

COPY ./Gemfile $APP_PATH/Gemfile
COPY ./Gemfile.lock $APP_PATH/Gemfile.lock

RUN bundle install