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

require 'test_helper'

class Gonzales::FactoryGirl::DefinitionProxyTest < ActiveSupport::TestCase

  class DefinitionProxyTest
    include Gonzales::FactoryGirl::DefinitionProxy
    
    attr_accessor :sylvester
    
    def after_build
      yield self
    end
  end
  
  setup do
    @proxy = DefinitionProxyTest.new
  end
  
  
  context 'speedy association' do
    setup do
      @proxy.sylvester = nil
    end
    should 'instantiate factory with default attribute' do
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(nil)
      Factory.expects(:create).with(:sylvester, {}).returns(:cat)
      @proxy.speedy(:sylvester)
      assert_equal :cat, @proxy.sylvester
    end
    should 'instantiate factory with defined attribute' do
      Gonzales::Collection.expects(:entity).with(:elmer).returns(nil)
      Factory.expects(:create).with(:elmer, {}).returns(:cat)
      @proxy.speedy(:sylvester, :elmer)
      assert_equal :cat, @proxy.sylvester
    end
    should 'not try to instantiate factory or find entity from cache if attribute is set' do
      @proxy.sylvester = :already_set
      Gonzales::Collection.expects(:entity).never
      Factory.expects(:create).never
      @proxy.speedy(:sylvester)
      assert_equal :already_set, @proxy.sylvester
    end
    should 'load entity from cache if it is there' do
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(:cat)
      Factory.expects(:create).never
      @proxy.speedy(:sylvester)
      assert_equal :cat, @proxy.sylvester
    end
  end
    
end
