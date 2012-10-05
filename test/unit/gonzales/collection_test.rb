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

class Gonzales::CollectionTest < ActiveSupport::TestCase
  
  setup do
    @coll = Gonzales::Collection
  end
  
  context 'private method' do
    context 'dirty' do
      should 'save file immediately, since destructor is a unknown thing in ruby' do
        entities = stub('entities')
        @coll.instance_variable_set(:@entities, entities)
        entities.expects(:to_yaml).returns('xyz')
        file = stub('file')
        File.expects(:open).with(Rails.root.join('tmp','speedy.yml'), 'w+').yields(file)
        file.expects(:write).with('xyz')
        @coll.send(:dirty)
      end
    end
    context 'load' do
      # YAML.expects(:load_file).with( Rails.root.join('tmp','speedy.yml'))
      # @coll.send(:load)
    end
  end
  
  context 'publich method' do
    context 'add' do
      should 'store entity' do
        class Entity
          def id
            5
          end
        end
        @coll.expects(:dirty).once
        @coll.entities.expects(:[]=).with(:gonzales, :class => 'Gonzales::CollectionTest::Entity', :id => 5)
        @coll.add(:gonzales, Entity.new)      
      end
    end
    context 'entity' do
      should 'find record if it has been cached' do
        Entity.expects(:find).with(2).returns(:midd)
        @coll.entities.expects(:[]).with(:entity).returns({:class => 'Gonzales::CollectionTest::Entity', :id => 2})
        assert_equal :midd, @coll.entity(:entity)
      end
      should 'return nothing if not cached' do
        Entity.expects(:find).never
        @coll.entities.expects(:[]).with(:entity).returns(nil)
        assert_nil @coll.entity(:entity)
      end
    end
  end
  
end
