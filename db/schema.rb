# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_29_120935) do

  create_table "applist_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "applist_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_applist_tags_on_applist_id"
    t.index ["tag_id"], name: "index_applist_tags_on_tag_id"
  end

  create_table "applists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "appid", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "header_image_url", null: false
    t.text "glance_detail"
    t.text "description"
    t.string "review_summary"
    t.datetime "release_date"
    t.string "developer"
    t.bigint "applist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_contents_on_applist_id"
  end

  create_table "discarded_applists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "appid", null: false
    t.string "name", null: false
    t.datetime "release_date"
    t.integer "game_purchase_price"
    t.string "review_summary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "url"
    t.bigint "applist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_movies_on_applist_id"
  end

  create_table "news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "title", null: false
    t.text "url", null: false
    t.string "author"
    t.text "contents"
    t.integer "date"
    t.bigint "applist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_news_on_applist_id"
  end

  create_table "prices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "game_purchase_price"
    t.string "discount_pct"
    t.string "discount_original_price"
    t.string "discount_final_price"
    t.bigint "applist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_prices_on_applist_id"
  end

  create_table "screenshot_hds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "url", null: false
    t.bigint "applist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_screenshot_hds_on_applist_id"
  end

  create_table "screenshot_poors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.text "url", null: false
    t.bigint "applist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["applist_id"], name: "index_screenshot_poors_on_applist_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.integer "record_num"
    t.string "name_record"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "web_scrapings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "applists_length"
    t.integer "scraped_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "applist_tags", "applists"
  add_foreign_key "applist_tags", "tags"
  add_foreign_key "contents", "applists"
  add_foreign_key "movies", "applists"
  add_foreign_key "news", "applists"
  add_foreign_key "prices", "applists"
  add_foreign_key "screenshot_hds", "applists"
  add_foreign_key "screenshot_poors", "applists"
end
