class Shoe < ActiveRecord::Base
  belongs_to :upper_material, :class_name => 'Material'
  belongs_to :lower_material, :class_name => 'Material'
  belongs_to :inner_material, :class_name => 'Material'
  attr_accessible :name, :size
end
