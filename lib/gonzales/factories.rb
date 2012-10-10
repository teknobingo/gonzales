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

module Gonzales
  # = Gonzales::Factories
  #
  # Facitity to instantiate factories in database during db:test:prepare
  class Factories
    # Save a factory based record to the test database before executing tests
    #
    # === Arguments
    #  * alias_name - optional alias name (can be used to reference factory or associations later)
    #  * factory_name - the name of the factory (use to reference factory or associations later if alias is not given)
    #  * options - a hash to be passed to FactoryGirl when creating the record
    #
    # === Examples
    #   Gonzales::Factories.load do |go|
    #     go.speedy :address
    #     go.speedy :organization
    #     go.speedy :john, :person, :name => 'John'
    #   end
    #
    def self.speedy(factory_or_alias_name, *args)
      alias_name = factory_or_alias_name
      options = args.extract_options!
      factory_name = args.first || alias_name
      Collection.add alias_name, Factory.create(factory_name, options)
    end
    
    # Yields a block to define speedy statements, then saves a collection of references to a temporary file
    def self.load(&block)
      ::FactoryGirl.reload
      yield self
      Collection.save
    end
  end
end