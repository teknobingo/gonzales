# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121010161218) do

  create_table "hats", :force => true do |t|
    t.string   "brim_type"
    t.integer  "size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hats_outfits", :force => true do |t|
    t.integer "hat_id"
    t.integer "outfit_id"
  end

  add_index "hats_outfits", ["hat_id"], :name => "index_hats_outfits_on_hat_id"
  add_index "hats_outfits", ["outfit_id"], :name => "index_hats_outfits_on_outfit_id"

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "outfits", :force => true do |t|
    t.string   "style"
    t.integer  "shoe_id"
    t.integer  "hat_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "outfits", ["hat_id"], :name => "index_outfits_on_hat_id"
  add_index "outfits", ["shoe_id"], :name => "index_outfits_on_shoe_id"

  create_table "shoes", :force => true do |t|
    t.string   "name"
    t.integer  "upper_material_id"
    t.integer  "lower_material_id"
    t.integer  "inner_material_id"
    t.integer  "size"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "shoes", ["inner_material_id"], :name => "index_shoes_on_inner_material_id"
  add_index "shoes", ["lower_material_id"], :name => "index_shoes_on_lower_material_id"
  add_index "shoes", ["upper_material_id"], :name => "index_shoes_on_upper_material_id"

end
