class AddWardrobeToOutfit < ActiveRecord::Migration
  def change
    add_column :outfits, :wardrobe_id, :integer
  end
end
