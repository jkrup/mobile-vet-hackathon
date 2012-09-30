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

ActiveRecord::Schema.define(:version => 20120930055549) do

  create_table "billing_items", :force => true do |t|
    t.integer  "visit_id"
    t.integer  "item_id"
    t.integer  "pet_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price",       :precision => 9, :scale => 2
    t.boolean  "is_active"
    t.string   "role"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "pets", :force => true do |t|
    t.string   "name"
    t.string   "specie"
    t.integer  "age"
    t.text     "medical_history"
    t.integer  "client_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "requests", :force => true do |t|
    t.text     "requested_slots_serialized"
    t.integer  "user_id"
    t.integer  "assigned_vet_id"
    t.integer  "round_count"
    t.string   "visit_type"
    t.text     "nos_serialized"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                   :default => "",       :null => false
    t.string   "encrypted_password",      :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "role",                    :default => "client"
    t.text     "availability_serialized"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "stripe_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "visits", :force => true do |t|
    t.boolean  "is_home"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "client_id"
    t.integer  "provider_id"
    t.string   "workflow_state"
    t.time     "start_time"
    t.string   "visit_type"
  end

end
