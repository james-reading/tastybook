# README

[app_name]

[app description]

## Getting started

cp config/database.yml.example config/database.yml

Edit config/database.yml

rake db:setup

yarn install

## Configure Skylight.io

Skylight is being used for performance analysis. Request the authentication from nicolas@cookieshq.co.uk

## Using tmuxinator?

Edit tmuxinator .yml file
ln -s config/tmuxinator.yml .tmuxinator/app_name.yml


## To be created in Heroku

ENV['RAILS_SERVE_STATIC_FILES'].present?
ENV.fetch("ASSET_HOST", ENV.fetch("APPLICATION_HOST"))
ENV["RACK_TIMEOUT"] || 10
ENV['BUGSNAG_API_KEY']
ENV['SKYLIGHT_AUTHENTICATION']

