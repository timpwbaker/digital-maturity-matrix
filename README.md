# Third Sector Digital Maturity Matrix

The Third Sector Digital Maturity Matrix is a tool for charities to measure and
set targets for their digital maturity. 

## Setup

The application is Ruby on Rails 5.1 and uses a Postgres database, so make sure
you've got postgres installed, and then

    bundle install
    rails db:create

You could create your own matrix, but there's on pre created in the database dump
in the root. Load it:

    pg_restore --verbose --clean --no-acl --no-owner -h localhost -U {{YOUR_USERNAME}} -d maturity_matrix_db_development test.dump

Tests are RSpec, to run:

    rspec
