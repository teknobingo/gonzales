require 'test_helper'

class GonzalesTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Gonzales
  end
  
  context 'initializing' do
    should 'load factory_file' do
      Gonzales.factory_module = nil
      Gonzales::Collection.expects(:clear_cache).never
      Gonzales.expects(:load).with(Rails.root.join('test', 'speedy.rb'))
      Gonzales.initialize!
    end
    should 'not load factory_file if disable_preload' do
      Gonzales.factory_module = nil
      Gonzales.disable_preload = true
      Gonzales::Collection.expects(:clear_cache).once
      Gonzales.expects(:load).never
      Gonzales.initialize!
      Gonzales.disable_preload = false
    end
  end
  
  context 'customization' do
    should 'include adapter as config' do
      Gonzales::Adapter.expects(:use).with(:registered)
      Gonzales.configure do |config|
        config.adapter = :registered
      end
    end
    should 'include adapter as accessor' do
      Gonzales::Adapter.expects(:use).with(:registered)
      Gonzales.adapter = :registered
    end
  end

end
