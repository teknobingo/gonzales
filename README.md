# Gonzales

After struggling with some slow running tests you will probably want to speed them up. Factory girl is somewhat slow, because it will try to create new records in the database before each test is running. Fixtures works much faster but with less flexibility.

Using Gonzales, reduced my unit-tests time from 1 minute 40 seconds, down to 24 seconds.

Well, Gonzales makes the best out of Factory Girl, by allowing you to load the factories into the database before the tests starts. 
You just have to learn one new keyword - ```speedy```. You will use ```speedy``` for:

   * Saving factories to test database before running tests
   * Declaring associations in factories
   * Refering to objects that were saved to test database before tests started

# Install and Setup

Install the gem

    gem install gonzales
    
Or, in your Gemfile

    gem 'gonzales'
    
## Initializing your factories before the tests are running

Define a file in your test directory called speedy.rb. Enlist all the factories you want to load before tests are running using the ```speedy``` command.

``` Ruby
# test/speedy.rb
Gonzales::Factories.load do |go|
  go.speedy :address
  go.speedy :organization
  go.speedy :person
  go.speedy :john, :person, :name => 'John'
end
```
The latter is creating the alias ```john``` to ```person``` and also changing its ```name``` attribute. This way you can easily customize associations in your factories. 

Then, you will need to initialize Gonzales before you run your tests.
Add this file to your lib/tasks directory:

``` Ruby
# lib/tasks/gonzales_tasks.rake
namespace :db do
  namespace :test do
    task :prepare => :environment do
      # place your seeds here, if you have any
      Gonzales.initialize!
    end
  end
end
```

# Important command - speedy

## Loading association with speedy

A model with many associations may be very slow to instantiate. Lets say you have a person that has an address, and the person belongs to an organization with an address; that is four records that needs to be created in the database just for one person. If you need multiple roles in a test, that is the multitude of the number of roles you use in the test. By creating the records in the test database before running the tests, the tests will run much faster.

You will use the keyword ```speedy``` with factory girl to define associations

``` Ruby
# test/factories.rb
FactoryGirl.define do
  
  factory :organization do
    name 'Looney tunes'
    speedy :address
  end

  factory :person do
    name 'Sylvester'
    speedy :organization
    speedy :address
  end
end
```

```speedy``` is in reality implemented so that if you have defined the association with Factory.create command, it will be preserved. The code:

``` Ruby
  Factory.create :person, :organization => @organization
```

In practice the ```speedy``` association command does something like this:

``` Ruby
  after_build { |r| r.organization = pre_created_organization || Factory.create(:organization) unless r.organization }
```

## Instantiating a pre-created object defined with factory girl using speedy

In order to fetch an object that has already been pre-created you'll use the ```speedy``` command for that too.
In your test you will write something like this:

``` Ruby
class HatTest < ActiveSupport::TestCase
  setup do
    @person = speedy :person
  end
  ...
end
```

If the factory has not been pre-created speedy will just call Factory.create. And of course, if you want to, you can still use Factory.build or Factory.create, but then they will work like traditional FactoryGirl usage.

## Using speedy with integration tests

If you are using (DatabaseCleaner)[https://github.com/bmabey/database_cleaner], and probably (Capybara)[https://github.com/jnicklas/capybara], when running integration tests, you will probably face some challenges. However, do not despair, you may be able to work around this. Since you do not want to load all your factories in advance, you can let Gonzales load them as you need them. I recomment the following settings in your integration_test_helper file:

``` Ruby

Gonzales.configure do |config|
  config.disable_preload = true         # ensures that the spoeedy file is not loaded when initializing Gonzales
  config.adapter = :registered          # ensures factories created are cached as they would be when loaded from speedy file.
end

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL
    # Stop ActiveRecord from wrapping tests in transactions
    self.use_transactional_fixtures = false
    DatabaseCleaner.clean                 # Truncate the database before tests are run the first time
    Gonzales.initialize!                  # Ensure any cache is cleared before we run the tests

    teardown do
      DatabaseCleaner.clean               # Truncate the database
      Capybara.reset_sessions!            # Forget the (simulated) browser state
      Capybara.use_default_driver         # Revert Capybara.current_driver to Capybara.default_driver
      Gonzales.initialize!                # Ensure cache is cleared after running each test
    end

    def capture_and_open_screen
      tmp = Tempfile.new('capture_and_open_screen')
      tmp.close
      system("screencapture -P #{tmp.path}")
      system("open -a Preview \"file://#{tmp.path}\"")
    end
  end
end
```


Thats all there is to it. Speedy coding!