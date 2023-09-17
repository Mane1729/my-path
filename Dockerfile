FROM ruby:3.1.2

ARG PORT=3000

RUN apt-get update -qq && apt-get install -y python3 python3-pip postgresql-client postgresql-contrib libpq-dev build-essential 

WORKDIR /app
RUN gem update --system
RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install
RUN pip3 install numpy pandas scikit-learn==1.2.2 joblib


ADD . /app

EXPOSE ${PORT}
CMD bin/rails server -p 3000 -b '0.0.0.0'