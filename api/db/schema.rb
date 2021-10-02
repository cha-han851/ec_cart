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

ActiveRecord::Schema.define(version: 0) do

  create_table "accounts", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "first_name", null: false, comment: "名"
    t.string "last_name", null: false, comment: "姓"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "phone", null: false, comment: "電話番号"
    t.string "zip", null: false, comment: "郵便番号"
    t.string "address_one", null: false, comment: "都道府県 市区町村"
    t.string "address_two", null: false, comment: "番地"
    t.string "address_three", comment: "建物名"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_accounts_on_uid_and_provider", unique: true
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリー名"
    t.string "serial_prefix", null: false, comment: "シリアル番号 接頭辞"
    t.text "description", comment: "カテゴリー説明"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deliveries", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "first_name", null: false, comment: "名"
    t.string "last_name", null: false, comment: "姓"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "phone", null: false, comment: "電話番号"
    t.string "zip", null: false, comment: "郵便番号"
    t.string "address_one", null: false, comment: "都道府県 市区町村"
    t.string "address_two", null: false, comment: "番地"
    t.string "address_three", comment: "建物名"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false, comment: "商品名"
    t.text "description", comment: "商品説明"
    t.integer "price", default: 0, null: false, comment: "商品価格"
    t.string "serial_number", null: false, comment: "シリアルナンバー"
    t.integer "stock", default: 0, null: false, comment: "商品在庫"
    t.integer "display_flag", default: 0, null: false, comment: "公開・非公開フラグ 0:非公開 1:公開"
    t.text "main_image_url", null: false, comment: "メイン画像URL"
    t.string "main_image_alt", comment: "メイン画像alt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id", null: false, comment: "カテゴリーID"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "purchase_histories", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "payment_type", default: 0, null: false, comment: "お支払い方法 0:代金引換 1:クレジットカード"
    t.integer "delivery_type", default: 0, null: false, comment: "配達方法 0:お届け(玄関) 1:お届け(宅配BOX) 2:コンビニ受取"
    t.text "message", comment: "要望等"
    t.integer "total_price", default: 0, null: false, comment: "合計金額"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false, comment: "アカウントID"
    t.bigint "delivery_id", null: false, comment: "お届け先ID"
    t.index ["account_id"], name: "index_purchase_histories_on_account_id"
    t.index ["delivery_id"], name: "index_purchase_histories_on_delivery_id"
  end

  create_table "purchase_products", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "total_count", default: 0, null: false, comment: "商品別 購入数"
    t.integer "total_price", default: 0, null: false, comment: "商品別 合計金額"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "purchase_history_id", null: false, comment: "商品購入履歴ID"
    t.bigint "product_id", null: false, comment: "商品ID"
    t.index ["product_id"], name: "index_purchase_products_on_product_id"
    t.index ["purchase_history_id"], name: "index_purchase_products_on_purchase_history_id"
  end

end
