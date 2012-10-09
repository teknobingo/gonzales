require 'test_helper'

class ShoeTest < ActiveSupport::TestCase
  setup do
    Gonzales.initialize!
  end
  context 'loading shoe' do
    should 'not call factory' do
      Factory.expects(:create).never
      hat = speedy(:shoe)
    end
  end
end
