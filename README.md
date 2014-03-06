spree_smooth_checkout
=====================

Smooths out the spree checkout process.

Installation
------------

Add spree_smooth_checkout to your Gemfile:

```ruby
gem 'spree_smooth_checkout'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_smooth_checkout:install
```

Development
-----------

Vagrant can be used to boot up an environment that's already configured for developing on the gem.

```shell
vagrant up
```

This will start the box and provision it with the required dependencies.

The source code will be located in the /code directory on the VM.

Manual Testing
--------------

The gem includes a test Spree store that can be used for manual testing in the ./teststore directory.

To run the teststore for the first time run the commands below. This will configure the database and add the required test data.

```shell
cd teststore
bundle

bundle exec rake railties:install:migrations
bundle exec rake db:migrate
bundle exec rake db:seed

rails s
```

From then onwards you should be able to just run from the teststore directory.

```shell
rails s
```

The port for the teststore will be forwarded from port 30000 on your local machine.

When the store is running you should be able to visit https://lvh.me:30000 to see the store running on the VM.

Copyright © 2014, 200 X Ltd trading as 200 Creative. All rights reserved.
