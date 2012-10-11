class CreateHatsOutfits < ActiveRecord::Migration
  def change
    create_table :hats_outfits do |t|
      t.belongs_to :hat
      t.belongs_to :outfit
    end
    add_index :hats_outfits, :hat_id
    add_index :hats_outfits, :outfit_id
  end
end
