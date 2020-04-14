# Learnables

This is an application intended to aid in the distant learning settings currently employed in various schools. Teachers can create courses that will take students through a topic. You can create informative pages that may also include a question about the read material or question only pages.

# Installation
This section will cover how to install this app. If you are familiar with deploying Rails applications, you can skip this section - there is nothing special (except maybe the prerequisites below).

## Prerequisites

Things you may want to cover:

* Ruby version 2.7 or above

* PostgreSQL databases (it should work with any other database supported by ActiveRecord)

* Gems and JavaScript packages as specified in `Gemfile` and `package.json` (for installation instructions see below).

## Installing gems and JS packages

Note that depending on your deployment, you do not have to do any of the steps described here. If, for example, you deploy to heroku, this will all be done automatically. When running it locally, or for development and testing, you should follow these instructions.

To install all gems, you will need to install the `bundler` gem:
```shell script
gem install bundler
```

Then, `cd` into the project directory and run
```shell script
bundle install
```

The JavaScript packages are installed with
```shell script
rake yarn:install
```

That's it, you're ready to go!

## Getting up and running

### Setting up credentials.yml.enc
Delete the file `config/credentials.yml.enc`. Then run
```shell script
EDITOR=vim rails credentials:edit
```
in the command line. You can replace vim with your favorite editor. This will open an editor that opens the credentials file. The point of this command is only to create your `master.key` and `credentials.yml.enc` file. You can quit the editor right away, unless you need to input credentials.

**Important** Keep a copy of your credentials file, as it will most likely be replaced when you pull a current copy of the learnables app. After updating, just replace the `credentials.yml.enc` with the your personal copy.

#### Master key
The rails app needs to know your master key. There are two ways of doing so on your production machine:
1) Upload the master key onto the server (in a safe location that cannot be accessed by the web!). Then symlink it to the rails app.
2) Create a `RAILS_MASTER_KEY` environment variable on the server that contains the master key. Rails will detect it and use it. On Heroku, you could do it like this: 
    ```shell script
    heroku config:set RAILS_MASTER_KEY=<your-master-key>
    ```
    You will need the heroku cli installed for this to work.

#### What is `config/credentials.yml.enc` for?
The `config/credentials.yml.enc` file is where you store your private credentials. It is safe to store it in version control and push it to your server as it is encrypted. To decrypt, you will need the `config/master.key`. This file _must not_ be put into version control! You will, however need a copy on the server running the app. Otherwise, Rails will not be able to read your credentials file.

### Initializing the database

#### Database names
First of all, set up `config/database.yml` so you can connect to your database. The default deployment settings are:
```ruby
database: learnables_production
username: learnables
password: <%= ENV['LEARNABLES_DATABASE_PASSWORD'] %>
```

1) Change the username to the username you were assigned by your hosting provider or make sure your database has a user `learnables`.
2) If you were assigned a database, change `database` to the provided name. It is highly recommended that you have a database that is only used by this application to avoid naming clashes.

Please note that updating the application will be easier if you leave the username and database as is.

#### Creating the database

In the terminal, run the command

````shell script
rake db:setup
````

Your setup is done. This will create the database with all tables and the admin user. By default, the admin user has the following name and password:
```
username: Admin
password: change-me!
```

You can now go to the application in your browser and log in. Please change the username immediately! It is also recommended that you create a new user with limited access for your daily usage, as the admin user can also delete all content and accounts.

#### Updating
Copy the following files:
* `config/credentials.yml`
* `config/database.yml`

and all other files you changed (the two above are the most obvious). After that, you can update your app.

Then, run
```shell script
rails db:migrate
```
and copy your files you copied at the beginning back into the app. This should be everything you need to do after installing the new version.

**Note:** If you have a master key linked to your app, you might have to relink this file. Also 