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

ActiveRecord::Schema.define(:version => 20121011214427) do

  create_table "chats", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "upload_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["upload_id"], :name => "index_comments_on_upload_id"

  create_table "communications", :force => true do |t|
    t.integer  "chat_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "seen",       :default => false
  end

  add_index "communications", ["chat_id"], :name => "index_communications_on_chat_id"
  add_index "communications", ["user_id"], :name => "index_communications_on_user_id"

  create_table "conversations", :force => true do |t|
    t.integer  "chat_id"
    t.string   "message",    :limit => 10000
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
  end

  add_index "conversations", ["chat_id"], :name => "index_conversations_on_chat_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.integer  "upload_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["upload_id"], :name => "index_tags_on_upload_id"

  create_table "uploads", :force => true do |t|
    t.string   "type"
    t.string   "url"
    t.string   "title"
    t.string   "about",      :limit => 10000
    t.integer  "user_id"
    t.string   "embedid"
    t.integer  "view"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "uploads", ["user_id", "created_at"], :name => "index_uploads_on_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
