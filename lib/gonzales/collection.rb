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
  class Collection
    class << self
      attr_reader :entities
      
      def add(factory_name, entity)
        entities ||= {}
        entities[factory_name] = { :class => entity.class.to_s, :id => entity.id }
        dirty
      end
      
      def entities
        @entities ||= load
      end
      
      def entity(factory_name)
        if e = entities[factory_name]
          e[:class].constantize.find e[:id]
        end
      end
      
    private
      def cache_filename
        @name ||= Rails.root.join('tmp', 'speedy.yml')
      end

      def dirty #:nodoc:
        # unless @dirty
        #   @dirty = true
        #   ObjectSpace.define_finalizer(self, proc {
        #     File.open(Rails.root.join('tmp', 'speedy.yml'), "w+") do |file|
        #       file.write @entities.to_yaml
        #     end
        #   })
        # end
        # Expect finalizer not to work, so...
        File.open(Rails.root.join('tmp', 'speedy.yml'), "w+") do |file|
          file.write @entities.to_yaml
        end
      end
      
      def load #:nodoc:
        YAML::load_file cache_filename
      end      
    end
  end
end