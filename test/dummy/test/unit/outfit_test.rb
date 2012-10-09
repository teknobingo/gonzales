require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
  setup do
    Gonzales.initialize!
  end
  context 'loading outfit' do
    should 'invoke factory for it and not for boot' do
      Factory.expects(:create).with(:outfit)
      outfit = speedy(:outfit)
    end
    should 'invoke factory for hat, but not for shoe' do
      Hat.expects(:find).never
      Shoe.expects(:find).once
      outfit = speedy(:outfit)
      assert_equal 'Narrow', outfit.hat.brim_type
    end
  end
end

