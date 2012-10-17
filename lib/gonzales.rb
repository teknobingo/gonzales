# Copyright (c) 2012 Bingo Entreprenøren AS
# Copyright (c) 2012 Teknobingo Scandinavia AS
# Copyright (c) 2012 Knut I. Stenmark
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'active_support/configurable'

module Gonzales
  # = Gonzales provides a mechanism for speeding up tests when using FactoryGirl
  #
  autoload :Adapter,    'gonzales/adapter'
  autoload :Collection, 'gonzales/collection'
  autoload :Factories,  'gonzales/factories'
  autoload :TestHelper, 'gonzales/test_helper'

  include ActiveSupport::Configurable
  
  # == Configurations
  #
  #   * factory_module  - the module containing the definitions of factories to be store in the test database.
  #                       Defaults to +test/speedy.rb+
  #   * factory_cache   - the entity lookup yaml-file to store factories that was save to the database when Gonzales.initialize! was run
  #                       Defaults to +test/speedy.yml+
  #   * disable_preload - Set to true if you want to disable preload for integration tests. If you are using database_cleaner, you
  #                       will probably also set this one to true.
  #   * adapter         - Set to either :registered or :unregistered. When using database_cleaner with integration_tests and you want
  #                       to reuse associations decleared with speedy, you should set this value to :registered
  # === Example 
  #
  # Gonzales.configure do |config|
  #   config.factory_module = Rails.root.join('tmp', 'gonzales.yml')
  #   config.factory_cache =  Rails.root.join('test', 'speedy.rb')
  # end
  config_accessor :factory_module, :factory_cache, :disable_preload, :adapter

  self.config.class.redefine_method(:adapter=) do |name|
    Gonzales::Adapter.use name
  end

  # def self.adapter=(name)
  #   Adapter.use name
  # end
  
  # Runs the initialization of Gonzales. Put this in a rake task for your application.
  #
  # === Example
  #
  #   # lib/tasks/gonzales_tasks.rake
  #   namespace :db do
  #     namespace :test do
  #       task :prepare => :environment do
  #         # place your seeds here, if you have any
  #         Gonzales.initialize!
  #       end
  #     end
  #   end
  #
  def self.initialize!
    unless disable_preload
      load(factory_module || Rails.root.join('test', 'speedy.rb'))
    else
      Collection.clear_cache
    end
  end
end

require 'gonzales/factory_girl/definition_proxy'
require 'factory_girl'
FactoryGirl::DefinitionProxy.send(:include, Gonzales::FactoryGirl::DefinitionProxy)
ActiveSupport::TestCase.send(:include, Gonzales::TestHelper)
