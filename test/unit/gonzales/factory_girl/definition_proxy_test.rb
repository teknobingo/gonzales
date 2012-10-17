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
    attr_accessor :cartoons
    
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
      @reflection = stub('reflection', :macro => :belongs_to)
    end
    should 'instantiate factory with default attribute' do
      DefinitionProxyTest.expects(:reflect_on_association).with(:sylvester).returns(@reflection)
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(nil)
      Gonzales::Adapter.expects(:create).with(:sylvester, {}).returns(:cat)
      @proxy.speedy(:sylvester)
      assert_equal :cat, @proxy.sylvester
    end
    should 'instantiate factory with defined attribute' do
      DefinitionProxyTest.expects(:reflect_on_association).with(:sylvester).returns(@reflection)
      Gonzales::Collection.expects(:entity).with(:elmer).returns(nil)
      Gonzales::Adapter.expects(:create).with(:elmer, {}).returns(:cat)
      @proxy.speedy(:sylvester, :elmer)
      assert_equal :cat, @proxy.sylvester
    end
    should 'not try to instantiate factory or find entity from cache if attribute is set' do
      DefinitionProxyTest.expects(:reflect_on_association).with(:sylvester).returns(@reflection)
      @proxy.sylvester = :already_set
      Gonzales::Collection.expects(:entity).never
      Gonzales::Adapter.expects(:create).never
      @proxy.speedy(:sylvester)
      assert_equal :already_set, @proxy.sylvester
    end
    should 'load entity from cache if it is there' do
      DefinitionProxyTest.expects(:reflect_on_association).with(:sylvester).returns(@reflection)
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(:cat)
      Gonzales::Adapter.expects(:create).never
      @proxy.speedy(:sylvester)
      assert_equal :cat, @proxy.sylvester
    end
  end

  context 'speedy has_many and has_and_belongs_to_many association' do
    setup do
      @proxy.cartoons = []
    end
    should 'associate many elements as array' do
      macro = :has_and_belongs_to_many
      reflection = stub('reflection', :macro => macro)
      DefinitionProxyTest.expects(:reflect_on_association).with(:cartoons).returns(reflection)
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(:cat)
      Gonzales::Collection.expects(:entity).with(:elmer).returns(:man)
      Factory.expects(:create).never
      @proxy.speedy(:cartoons, :sylvester, :elmer)
      assert_equal [:cat, :man], @proxy.cartoons, "Association failed for macro: #{macro}"
    end
    should 'not try to instantiate factory or find entity from cache if attribute is set' do
      @proxy.cartoons = [:dog]
      macro = :has_many
      reflection = stub('reflection', :macro => macro)
      DefinitionProxyTest.expects(:reflect_on_association).with(:cartoons).returns(reflection)
      Gonzales::Collection.expects(:entity).never
      Factory.expects(:create).never
      @proxy.speedy(:cartoons, :sylvester)
      assert_equal [:dog], @proxy.cartoons, "Association failed for macro: #{macro}"
    end
  end
  
end
