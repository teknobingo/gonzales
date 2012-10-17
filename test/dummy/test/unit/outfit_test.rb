require 'test_helper'

class OutfitTest < ActiveSupport::TestCase
  
  context 'default use' do
    setup do
      Gonzales.initialize!
    end
    context 'loading outfit' do
      should 'invoke factory for it and not for boot' do
        Gonzales::Adapter.expects(:create).with(:outfit)
        outfit = speedy(:outfit)
      end
      should 'invoke factory for hat, but not for shoe' do
        Hat.expects(:find).never
        Shoe.expects(:find).once
        outfit = speedy(:outfit)
        assert_equal 'Narrow', outfit.hat.brim_type
      end
    end
    context 'outfit' do
      should 'have alternative thats association loaded' do
        outfit = speedy(:outfit)
        assert_equal 1, outfit.alternative_hats.size
        assert_equal 'Cool', outfit.alternative_hats.first.brim_type
      end
    end
    context 'exploring factory_girl' do
      should 'explore possibilities' do
        outfit = speedy(:girl_outfit)    
        assert_equal 'Fat', outfit.hat.brim_type
        assert_equal 'Classy', outfit.shoe.name
        assert_equal 1, outfit.alternative_hats.size
        assert_equal 'Narrow', outfit.alternative_hats.first.brim_type
      end
    end
  end
  
  context 'without preload and' do
    setup do
      Gonzales.disable_preload = true
      Gonzales.expects(:load).never
      Gonzales.initialize!
    end
    teardown do
      Gonzales.disable_preload = false      
      Gonzales.adapter = :unregistered
    end
    context 'using registered adapter' do
      setup do
        Gonzales.adapter = :registered
      end
      should 'instantiate outfit only once' do
        assert_difference 'Outfit.count', 1 do
          speedy(:outfit)
          speedy(:outfit)
        end
      end
    end
    context 'using unregistered adapter' do
      setup do
        Gonzales.adapter = :unregistered
      end
      should 'instantiate outfit twice' do
        assert_difference 'Outfit.count', 2 do
          speedy(:outfit)
          speedy(:outfit)
        end
      end
    end
  end
  
end

