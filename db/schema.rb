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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_04_132033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.string "details"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notification_type"
  end

  create_table "order_items", force: :cascade do |t|
    t.string "name"
    t.decimal "approximate_weight"
    t.decimal "actual_weight"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer_name"
    t.integer "user_id"
    t.text "pickup_address"
    t.text "delivery_address"
    t.time "pickup_time"
    t.time "delivery_time"
    t.boolean "scheduled_delivery_request"
    t.boolean "for_self"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "pickup_date"
    t.date "delivery_date"
    t.integer "payment_method_id"
    t.boolean "payment_received"
    t.string "status"
    t.decimal "value"
    t.string "pickup_location_latitude"
    t.string "pickup_location_longitude"
    t.string "delivery_location_latitude"
    t.string "delivery_location_longitude"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "order_id"
    t.integer "payment_method_id"
    t.string "status"
    t.integer "payment_gateway_id"
    t.text "payment_response_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin"
    t.boolean "is_blacklisted"
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_signed_in"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "valets", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "aadhar_number"
    t.string "voter_id_number"
    t.string "current_latitude"
    t.string "current_longitude"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact_number"
  end

end
