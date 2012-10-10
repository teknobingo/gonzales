require 'test_helper'

class GonzalesTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Gonzales
  end
  
  context 'initializing' do
    should 'load factory_file' do
      Gonzales.factory_module = nil
      Gonzales.expects(:load).with(Rails.root.join('test', 'speedy.rb'))
      Gonzales.initialize!
    end
  end
end
