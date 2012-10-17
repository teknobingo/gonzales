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
  # = Gonzales::Adapter
  #
  # Adapter for instantiating factories in database
  module Adapter
    autoload :Registered,     'gonzales/adapter/registered'
    autoload :Unregistered,   'gonzales/adapter/unregistered'
    
    # Instantiates a record in the database with the defined factory. This is an internal method.
    #
    # The method will call either registered or unregistered adapter, depending on what was defined in the use method.
    #
    def self.create(factory_name, *options)
      @@adapter ||= Unregistered
      @@adapter.create(factory_name, *options)
    end
   
    # Sets the adapter to be used for instantiating objects based on predefioned factories. Internal.
    #
    def self.use(name)
      raise ArgumentError unless %w(registered unregistered).include? name.to_s
      @@adapter = "#{self}::#{name.to_s.classify}".constantize
    end
  end
end
