require 'test_helper'

class HatTest < ActiveSupport::TestCase
  setup do
    Gonzales.initialize!
  end
  context 'loading hat' do
    should 'not call factory' do
      Factory.expects(:create).never
      hat = speedy(:hat)
    end
  end
  
end
