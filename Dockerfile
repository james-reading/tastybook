FROM ruby:2.6.5

RUN apt-get update && apt-get install -y nodejs shared-mime-info

ADD . /app
WORKDIR /app
RUN gem install bundler:1.17.3
RUN bundle install
EXPOSE 3000
CMD ["bash"]
