# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_14_110454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.bigint "book_id"
    t.string "name", null: false
    t.boolean "is_representative", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_authors_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "google_books_api_id", null: false
    t.string "title", null: false
    t.string "image"
    t.string "publisher"
    t.date "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["google_books_api_id"], name: "index_books_on_google_books_api_id", unique: true
  end

  create_table "books_shelves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.text "comment", null: false
    t.integer "rating", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_books_shelves_on_book_id"
    t.index ["user_id", "book_id", "created_at"], name: "index_books_shelves_on_user_id_and_book_id_and_created_at"
    t.index ["user_id"], name: "index_books_shelves_on_user_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "user_id"
    t.text "chat_message_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "room_id"
    t.index ["room_id"], name: "index_chat_messages_on_room_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "goods", force: :cascade do |t|
    t.integer "user_id"
    t.integer "books_shelf_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["books_shelf_id"], name: "index_goods_on_books_shelf_id"
    t.index ["user_id"], name: "index_goods_on_user_id"
  end

  create_table "google_books", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "books_shelf_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["books_shelf_id"], name: "index_notifications_on_books_shelf_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.text "room_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_rooms", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at", precision: 6
    t.string "name"
    t.string "image"
    t.string "email"
    t.text "profile"
    t.string "age"
    t.string "locate"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "authors", "books"
  add_foreign_key "books_shelves", "books"
  add_foreign_key "books_shelves", "users"
  add_foreign_key "chat_messages", "rooms"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "goods", "books_shelves"
  add_foreign_key "goods", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
end
