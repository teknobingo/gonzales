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

require 'factory_girl'
module Gonzales
  # = Gonzales::TestHelper
  #
  # Helper to be used when writing tests when you use Gonzales
  module TestHelper
    # returns a created record to be used in tests
    #
    # speedy will return the record from the database if it alreday exists in the test database.
    # If not it will call FactoryGirl to instantiate the record.
    #
    # === Arguments
    #
    #   * factory_name - Name of the factory or the alias specified in the gonzales file
    #   * options - will be passed to FactoryGirl if the factory does not exist in the test database.
    #     Note!! options will not be passed to Gonzales. 
    #
    # === Example
    #
    #   setup do
    #     @person = speedy :person
    #   end
    #
    def speedy(factory_name, *options)
      Collection.entity(factory_name) || Factory.create(factory_name, *options)
    end
  end
end