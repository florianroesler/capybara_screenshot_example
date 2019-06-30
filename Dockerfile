FROM ruby:2.6.3

RUN apt-get update && apt-get install -y wget build-essential libxml2-dev libxslt-dev git less tzdata nodejs qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x cmake pkg-config

RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y google-chrome-stable && \
  rm -rf /var/lib/apt/lists/*

RUN gem update --system && gem install bundler && bundle config build.nokogiri --use-system-libraries

ENV APP_HOME=/app \
    BUNDLE_JOBS=4

WORKDIR $APP_HOME

RUN mkdir -p $APP_HOME

COPY Gemfile* $APP_HOME/

RUN bundle install

COPY . $APP_HOME/

CMD start.sh 3000 production
