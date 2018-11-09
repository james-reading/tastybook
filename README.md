# README

[app_name]

[app description]

## Getting started

### Requirements

- Ruby 2.5.1
- yarn
- bundle

### Install all the gems

    $ bundle install

### Database setup

Run

    $ cp config/database.yml.example config/database.yml

Edit `config/database.yml` and update the database name for the development and test entry

Then setup your database

    $ rake db:setup

### Webpacker

Install the required packages

    $ yarn install

If you are using Tmuxinator, webpacker server will be started as part of your instance.
If you want to start the webpack server on your own, please run

    $ ./bin/webpack-dev-server

### Running the app

Install the heroku CLI tools [link](https://devcenter.heroku.com/articles/heroku-cli)

Then run

    $ heroku local

### Setup tmuxinator

Edit `config/tmuxinator.yml` and change the app name

Then run

    $ ln -s config/tmuxinator.yml .tmuxinator/[app_name].yml

You should now be able to launch the project with

    $ tmuxinator app_name

### Heroku variables

You will need to create a few variables on your Heroku app instance.

- `APPLICATION_HOST` to receive something like `www.appdomain.com`
- `ASSET_HOST` to either receive something like `www.appdomain.com` or will use APPLICATION_HOST if not present
- `MAX_THREADS` default to 2
- `RAILS_SERVE_STATIC_FILES` default to `enabled`
- `WEB_CONCURRENCY` default to 2
- `BUGSNAG_API_KEY` to receive your Bugsnag's project API KEY
- `SKYLIGHT_AUTHENTICATION` to receive your Skylight authentication ID
- `SECRET_KEY_BASE` to generate with `rake secret`

### Heroku setup

If using Skylight, you will need to activate the dyno metadata feature

    $ heroku labs:enable runtime-dyno-metadata -a <app name>

