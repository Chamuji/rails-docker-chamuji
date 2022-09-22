FROM ruby:2.7

ENV RAILS_ENV=production

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | wget --quiet -O - /tmp/pubkey.gpg  https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - d - \ && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \ && apt-get update -qq \ && apt-get install -y nodejs yarn

RUN set -x && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN set -x && apt-get update -y -qq && apt-get install -yq nodejs yarn

WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \ && bundle install

# apt-keyが使えないので、下記URLのコマンドを参考する
# https://zenn.dev/junki555/articles/2de6024a191913

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh","/start.sh"]
