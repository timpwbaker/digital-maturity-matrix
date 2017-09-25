# Third Sector Digital Maturity Matrix

The Third Sector Digital Maturity Matrix is a tool for charities to measure and
set targets for their digital maturity. 

## Setup

The application is Ruby on Rails 5.1 and uses a Postgres database, so make sure
you've got postgres installed, and then

    bundle install
    rails db:create

Log into heroku and pull the database, if you don't have the heroku creds
there's a test.dump in the root to get you started:

    heroku pg:pull DATABASE_URL maturity_matrix_db_development --app digital-maturity-matrix

Tests are RSpec, to run:

    rspec
