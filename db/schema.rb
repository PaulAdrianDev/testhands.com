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

ActiveRecord::Schema[8.0].define(version: 2025_08_16_101407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "archetypes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_archetypes_on_name", unique: true
  end

  create_table "board_cards", force: :cascade do |t|
    t.string "position", null: false
    t.bigint "board_id", null: false
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_cards_on_board_id"
    t.index ["card_id"], name: "index_board_cards_on_card_id"
  end

  create_table "board_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_board_types_on_name", unique: true
  end

  create_table "boards", force: :cascade do |t|
    t.integer "deck_summons", null: false
    t.integer "hand_summons", null: false
    t.integer "gy_banishment_summons", null: false
    t.bigint "deck_id", null: false
    t.bigint "board_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_type_id"], name: "index_boards_on_board_type_id"
    t.index ["deck_id"], name: "index_boards_on_deck_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "card_type", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cards_on_name", unique: true
  end

  create_table "deck_archetypes", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.bigint "archetype_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archetype_id"], name: "index_deck_archetypes_on_archetype_id"
    t.index ["deck_id"], name: "index_deck_archetypes_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.integer "tier", null: false
    t.text "advice"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "monster_card_details", force: :cascade do |t|
    t.string "monster_type", null: false
    t.string "monster_attribute", null: false
    t.boolean "is_effect", null: false
    t.integer "atk"
    t.integer "def"
    t.string "level"
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_monster_card_details_on_card_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "board_cards", "boards"
  add_foreign_key "board_cards", "cards"
  add_foreign_key "boards", "board_types"
  add_foreign_key "boards", "decks"
  add_foreign_key "deck_archetypes", "archetypes"
  add_foreign_key "deck_archetypes", "decks"
  add_foreign_key "decks", "users"
  add_foreign_key "monster_card_details", "cards"
  add_foreign_key "sessions", "users"
end
