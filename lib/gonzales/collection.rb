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
  # = Gonzales::Collection
  #
  # Holds references to the factories instantiated during db:test:prepare
  class Collection
    class << self
      
      # Adds an object (entity) to the collection.
      def add(name, object)
        entities[name] = { :class => object.class.to_s, :id => object.id }
      end
      
      # Retrieves the collection of entities.
      # If they are not already loded from the temporary cache map, the map is loaded.
      def entities
        @@entities ||= load
      end
      
      # Retrieves a specific object
      def entity(factory_name)
        if e = entities[factory_name]
          e[:class].constantize.find e[:id]
        end
      end

      # Save a collection map to temporary file
      def save #:nodoc:
        File.open(cache_filename, "w+") do |file|
          file.write entities.to_yaml
        end
      end
      
    private
      def cache_filename #:nodoc:
        @@cache_filename ||= Gonzales.factory_cache || Rails.root.join('tmp', 'speedy.yml')
      end

      def load #:nodoc:
        return {} if Gonzales.disable_preload
        begin
          YAML::load_file cache_filename
        rescue Errno::ENOENT
          {}
        end
      end      
    end
  end
end