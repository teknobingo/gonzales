class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :style
      t.belongs_to :shoe
      t.belongs_to :hat

      t.timestamps
    end
    add_index :outfits, :shoe_id
    add_index :outfits, :hat_id
  end
end
