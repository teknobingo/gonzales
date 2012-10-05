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

class Gonzales::FactoryGirl::DSLTest < ActiveSupport::TestCase

  class DSLTest
    include Gonzales::FactoryGirl::DSL
    
    attr_accessor :sylvester
    
    def after_build
      yield self
    end
  end
  
  setup do
    @dsl = DSLTest.new
  end
  
  
  context 'speedy association' do
    setup do
      @dsl.sylvester = nil
    end
    should 'instantiate factory with default attribute' do
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(nil)
      Factory.expects(:create).with(:sylvester).returns(:cat)
      @dsl.speedy(:sylvester)
      assert_equal :cat, @dsl.sylvester
    end
    should 'instantiate factory with defined attribute' do
      Gonzales::Collection.expects(:entity).with(:elmer).returns(nil)
      Factory.expects(:create).with(:elmer).returns(:cat)
      @dsl.speedy(:elmer, :sylvester)
      assert_equal :cat, @dsl.sylvester
    end
    should 'not try to instantiate factory or find entity from cache if attribute is set' do
      @dsl.sylvester = :already_set
      Gonzales::Collection.expects(:entity).never
      Factory.expects(:create).never
      @dsl.speedy(:sylvester)
      assert_equal :already_set, @dsl.sylvester
    end
    should 'load entity from cache if it is there' do
      Gonzales::Collection.expects(:entity).with(:sylvester).returns(:cat)
      Factory.expects(:create).never
      @dsl.speedy(:sylvester)
      assert_equal :cat, @dsl.sylvester
    end
  end
    
end
