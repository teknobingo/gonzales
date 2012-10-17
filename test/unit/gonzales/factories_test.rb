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

class Gonzales::FactoriesTest < ActiveSupport::TestCase

  context 'speedy' do
    should 'set collection to factory created by factory girl' do
      Factory.expects(:create).with('panchos', {}).returns('hideaway')
      Gonzales::Collection.expects(:add).with('panchos', 'hideaway').twice
      Gonzales::Factories.speedy('panchos')
      Factory.expects(:create).with('panchos', :merry => 'Melodies' ).returns('hideaway')
      Gonzales::Factories.speedy('panchos', :merry => 'Melodies')
    end
    should 'support alias name' do
      Factory.expects(:create).with('panchos', {}).returns('hideaway')
      Gonzales::Collection.expects(:add).with('villa', 'hideaway').twice
      Gonzales::Factories.speedy('villa', 'panchos')
      Factory.expects(:create).with('panchos', :merry => 'Melodies' ).returns('hideaway')
      Gonzales::Factories.speedy('villa','panchos', :merry => 'Melodies')
    end
  end
  
  context 'load' do
    should 'yield context' do
      Gonzales::Collection.expects(:clear_cache).once
      ::FactoryGirl.expects(:reload).once
      Gonzales::Collection.expects(:save).once
      Gonzales::Factories.load do |context|
        assert_equal Gonzales::Factories, context
      end
    end
  end
end
