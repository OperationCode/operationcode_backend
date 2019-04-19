FROM ruby:2.4.6-stretch

RUN apt-get update -qq \
    && apt-get install -y \
      build-essential \
      dpkg-dev \
      graphviz
      libpq-dev \
      nodejs \

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile $APP_HOME/
ADD Gemfile.lock $APP_HOME/

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

RUN bundle install --system

ADD . $APP_HOME/

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
