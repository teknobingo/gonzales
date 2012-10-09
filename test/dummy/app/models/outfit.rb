class Outfit < ActiveRecord::Base
  belongs_to :shoe
  belongs_to :hat
  attr_accessible :style
end
