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

ActiveRecord::Schema.define(version: 2021_08_18_125126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.integer "status", default: 0, null: false
    t.integer "current_round", default: 0, null: false
    t.bigint "question_set_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_set_id"], name: "index_games_on_question_set_id"
  end

  create_table "question_sets", force: :cascade do |t|
    t.string "name"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "question_set_id"
    t.string "option_1"
    t.string "option_1_img_url"
    t.string "option_2"
    t.string "option_2_img_url"
    t.string "option_3"
    t.string "option_3_img_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_set_id"], name: "index_questions_on_question_set_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "game_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_users_on_game_id"
  end

end
