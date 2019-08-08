#!/usr/bin/env bash
set -ex
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get install -y tzdata
gem install bundler -v 2.0.1
apt-get install -y cmake
# install
bundle install --without guard --deployment
# before_script
mysql -e 'create database chalmersit_test;'
cp config/secrets.example.yml config/secrets.yml
RAILS_ENV=test bundle exec rake db:migrate db:seed --trace
# script
RAILS_ENV=test bundle exec rspec
