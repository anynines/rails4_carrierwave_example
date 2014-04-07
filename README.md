# Rails 3.2.13 + Carrierwave + a9s Swift Service + PostgreSQL

We wrote a small application that demonstrates how Rails 3.2.13, Carrierwave, the a9s Swift Service and PostgreSQL work together.
This application is an adaptation of n0ne's [Rails-Carrierwave-jQuery-File-Upload application](https://github.com/n0ne/Rails-Carrierwave-jQuery-File-Upload).

You can use this application for a test run on [anyines.com](http://anyines.com).


### Install Codebase

Clone the git repository

    $ git clone https://github.com/anynines/rails4_carrierwave_example.git
    $ cd rails4_carrierwave_example
    $ bundle

Create a database and run migrations

    $ rake db:create db:migrate

Run the ```rails server```

    $ bundle exec rails s

### View Application

You can access the application using a browser: [localhost:3000](http://localhost:3000)

## Deploy the application to anynines

Install the a9s gem

    $ gem install a9s

Edit the deployment manifest

    $ cp manifest.yml.example manifest.yml
    $ vim manifest.yml -> exchange all occurences of your_app_name with your desired application identifier

The https://github.com/cloudfoundry/heroku-buildpack-ruby.git buildpack is referenced within the provided ```manifest.yml.example```. This buildpack is needed to support Rails 4 and Ruby 2.

Deploy the application

    $ cf push

## Test suite

RSpec and Capybara used for Integration and Unit tests

    $ rspec
