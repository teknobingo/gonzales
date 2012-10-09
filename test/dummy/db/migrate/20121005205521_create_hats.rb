class CreateHats < ActiveRecord::Migration
  def change
    create_table :hats do |t|
      t.string :brim_type
      t.integer :size

      t.timestamps
    end
  end
end
