# Rails 3.2.18 + Carrierwave + a9s Swift Service + PostgreSQL

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

### Service dependencies

* PostgreSQL
* Anynines Swift service

### Ruby cli (v5)

Install the a9s gem

    $ gem install a9s

Edit the deployment manifest

    $ cp manifest.yml.v5 manifest.yml
    $ vim manifest.yml -> exchange all occurences of your_app_name with your desired application identifier

The https://github.com/cloudfoundry/heroku-buildpack-ruby.git buildpack is referenced within the provided ```manifest.yml.v5```. This buildpack is needed to support Rails 4 and Ruby 2.

Deploy the application

    $ cf push

Visit the application url: http://your_app_name.de.a9sapp.eu .

### Go cli (v6)

Install the cf go cli: https://github.com/cloudfoundry/cli/releases

Edit the deployment manifest

    $ cp manifest.yml.v6 manifest.yml
    $ vim manifest.yml # exchange all occurences of your_app_name with your desired application identifier

Create the needed services

    $ cf create-service postgresql Pluto-free postgresql-your_app_name
    $ cf create-service swift free swift-your_app_name

Deploy the application

    $ cf push

Visit the application url: http://your_app_name.de.a9sapp.eu .

## Test suite

RSpec and Capybara used for Integration and Unit tests

    $ rspec
