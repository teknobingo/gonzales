class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name
      t.belongs_to :upper_material
      t.belongs_to :lower_material
      t.belongs_to :inner_material
      t.integer :size

      t.timestamps
    end
    add_index :shoes, :upper_material_id
    add_index :shoes, :lower_material_id
    add_index :shoes, :inner_material_id
  end
end
