#!/bin/sh
rvm use ruby-2.7.0@konduto-ruby
gem uninstall konduto-ruby
bundle install
gem build
gem install konduto-ruby --local konduto-ruby-2.2.0.gem