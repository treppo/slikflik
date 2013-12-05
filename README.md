# SlikFlik

[![Build Status](https://travis-ci.org/treppo/slikflik.png?branch=master)](https://travis-ci.org/treppo/slikflik)
[![Code Climate](https://codeclimate.com/github/treppo/slikflik.png)](https://codeclimate.com/github/treppo/slikflik)
[![Dependency Status](https://gemnasium.com/treppo/slikflik.png)](https://gemnasium.com/treppo/slikflik)
[![Coverage Status](https://coveralls.io/repos/treppo/slikflik/badge.png)](https://coveralls.io/r/treppo/slikflik)

## Development

### Prerequisites

 - Run `install_dev.sh` to install the Neo4J database package version 1.9 for testing and development and set the right ports.

 - Install gems with `bundle install`.

 - Get an [API key for themoviedb.org](http://docs.themoviedb.apiary.io/) and assign it to the `TMDB_API_KEY` shell environment variable by creating a file `.env`:

        # Replace 1234567890 with your key
        echo TMDB_API_KEY=1234567890 > .env

    This file will be used by foreman to set the right environment variable for the application.

### Getting started

Start the application and the databases with `bundle exec foreman start -f Procfile.dev` and browse to [http://localhost:9292]()

Run tests with `bundle exec rake` – this does not require an API key as API responses are prerecorded in test fixtures.
