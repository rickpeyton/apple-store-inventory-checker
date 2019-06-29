FROM ruby:2.4
RUN apt-get update && apt-get -y install git procps
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY lib/apple_store_inventory_checker/version.rb ./lib/apple_store_inventory_checker/
COPY Gemfile* ./
COPY apple_store_inventory_checker.gemspec ./
RUN bundle
RUN bundle exec yard gems
ENV SHELL /bin/bash
