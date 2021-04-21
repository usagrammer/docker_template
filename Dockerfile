FROM ruby:3.0.0

## updateしないとinstallできない
## updateの前2つやらないとyarnが古い
## imagemagickは最初から入ってる
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update

RUN apt-get install -y nodejs
RUN apt-get install -y yarn

#作業ディレクトリを指定している mkdirは不要
ENV APP_PATH=/project
WORKDIR $APP_PATH

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは別途事前に作成しておく）
COPY ./Gemfile $APP_PATH/Gemfile
COPY ./Gemfile.lock $APP_PATH/Gemfile.lock

RUN bundle install

CMD ["/bin/bash"]