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
  module FactoryGirl
    # = Gonzales::FactoryGirl::DefinitionProxy
    #
    # Extends FactoryGirl with a new extension
    module DefinitionProxy
      # Define an association in a factory.
      # Supports belongs_to and has_and_belongs_to_many associations
      #
      # speedy will assign the association in the following order:
      #
      #   #. If you have specified the association then insgtantiating creating or building the factory,
      #      it will use that association
      #   #. If the association exists in the database, it will assign that.
      #   #. Lastly, when none of the above, it will create the factory.
      #
      # === Arguments
      #   
      #  * association_name - the name of the association
      #  * factory_name - the name of the factory (if the factory has the same name as the association, this parameter is optional)
      #  * options - a hash to be passed to FactoryGirl when creating the record using factory
      #
      # === Examples
      #
      #    FactoryGirl.define do
      #      factory :organization do
      #        name "Looney tunes"
      #        speedy :contact                                      # association to contact (belongs_to :contact), 
      #               # same as +association :contact+
      #        speedy :addresses, :street_address, :postal_address  # association to addresses (has_many_and_belongs_to_many :addresses)
      #               # same as +addresses { |org| [org.association(:street_address), org.association(:postal_address)] }+
      #      end
      #    end
      #
      def speedy(attribute_or_factory, *args)
        attribute = attribute_or_factory
        options = args.extract_options!
        after_build do |r|
          if r.class.reflect_on_association(attribute).macro.to_s.include? 'has_and_belongs_to_many'
            if r.send(attribute).size == 0
              factory_names = args.size > 0 ? args : [attribute]
              r.send("#{attribute}=",
                factory_names.collect { |factory_name| Collection.entity(factory_name) || Adapter.create(factory_name, options) }) 
            end
          elsif !r.send(attribute)
            factory_name = args.first || attribute
            r.send("#{attribute}=", Collection.entity(factory_name) || Adapter.create(factory_name, options))
          end
        end
      end

    end
  end
end