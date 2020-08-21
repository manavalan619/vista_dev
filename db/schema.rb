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

ActiveRecord::Schema.define(version: 2019_01_09_101450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "label"
    t.string "line1"
    t.string "line2"
    t.string "town"
    t.string "county"
    t.string "postcode"
    t.string "country"
    t.string "phone"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
    t.index ["city_id"], name: "index_addresses_on_city_id"
  end

  create_table "answer_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.inet "ip_address"
    t.string "user_agent"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_answer_versions_on_item_type_and_item_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.citext "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.index ["position"], name: "index_answers_on_position"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "article_content_categories", force: :cascade do |t|
    t.bigint "article_id"
    t.bigint "content_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_article_content_categories_on_article_id"
    t.index ["content_category_id", "article_id"], name: "index_article_categories"
    t.index ["content_category_id"], name: "index_article_content_categories_on_content_category_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "publish_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "notification_job_id"
    t.index ["publish_at"], name: "index_articles_on_publish_at"
  end

  create_table "authentication_tokens", force: :cascade do |t|
    t.string "context"
    t.string "body"
    t.string "user_type"
    t.bigint "user_id"
    t.datetime "last_used_at"
    t.inet "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context"], name: "index_authentication_tokens_on_context"
    t.index ["user_type", "user_id"], name: "index_authentication_tokens_on_user_type_and_user_id"
  end

  create_table "branch_categorisations", force: :cascade do |t|
    t.bigint "branch_id", null: false
    t.bigint "partner_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_branch_categorisations_on_branch_id"
    t.index ["partner_category_id"], name: "index_branch_categorisations_on_partner_category_id"
  end

  create_table "branches", force: :cascade do |t|
    t.bigint "business_unit_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "telephone"
    t.datetime "archived_at"
    t.string "image"
    t.string "branch_info"
    t.string "booking_url"
    t.boolean "vista_partner", default: false
    t.integer "ratings_count", default: 0
    t.index ["business_unit_id"], name: "index_branches_on_business_unit_id"
    t.index ["vista_partner"], name: "index_branches_on_vista_partner"
  end

  create_table "business_units", force: :cascade do |t|
    t.string "name"
    t.bigint "organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.index ["organisation_id"], name: "index_business_units_on_organisation_id"
  end

  create_table "categories", force: :cascade do |t|
    t.citext "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ancestry"
    t.text "description"
    t.integer "position", default: 0, null: false
    t.boolean "initial", default: false
    t.jsonb "visibility_conditions", default: [], null: false
    t.string "text_style", default: "dark"
    t.integer "subtree_questions_count", default: 0
    t.integer "questions_count", default: 0
    t.index ["ancestry", "position"], name: "index_categories_on_ancestry_and_position"
    t.index ["ancestry"], name: "index_categories_on_ancestry"
  end

  create_table "category_updates", force: :cascade do |t|
    t.bigint "category_id"
    t.integer "question_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_updates_on_category_id"
    t.index ["question_ids"], name: "index_category_updates_on_question_ids", using: :gin
  end

  create_table "check_ins", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "branch_id"
    t.date "arrival_date"
    t.time "arrival_time_start"
    t.time "arrival_time_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_check_ins_on_branch_id"
    t.index ["user_id"], name: "index_check_ins_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["status"], name: "index_cities_on_status"
  end

  create_table "content_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_imports", force: :cascade do |t|
    t.string "file"
    t.string "status", default: "new"
    t.text "log"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "options", default: {}
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "user_id"
    t.string "platform"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform"], name: "index_devices_on_platform"
    t.index ["token"], name: "index_devices_on_token"
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "ignores", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_ignores_on_category_id"
    t.index ["user_id"], name: "index_ignores_on_user_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "staff_member_id"
    t.bigint "branch_id"
    t.bigint "category_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", default: "", null: false
    t.index ["branch_id"], name: "index_interactions_on_branch_id"
    t.index ["category_id"], name: "index_interactions_on_category_id"
    t.index ["staff_member_id"], name: "index_interactions_on_staff_member_id"
    t.index ["type"], name: "index_interactions_on_type"
    t.index ["user_id"], name: "index_interactions_on_user_id"
  end

  create_table "member_request_messages", force: :cascade do |t|
    t.text "body"
    t.string "status"
    t.bigint "member_request_id"
    t.integer "messageable_id"
    t.string "messageable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_request_id"], name: "index_member_request_messages_on_member_request_id"
    t.index ["messageable_type", "messageable_id"], name: "request_message_index"
  end

  create_table "member_request_type_assignments", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "member_request_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_request_type_id"], name: "index_member_request_type_assignments_on_member_request_type_id"
    t.index ["role_id"], name: "index_member_request_type_assignments_on_role_id"
  end

  create_table "member_request_types", force: :cascade do |t|
    t.string "name"
    t.bigint "business_unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.index ["business_unit_id"], name: "index_member_request_types_on_business_unit_id"
  end

  create_table "member_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "branch_id"
    t.bigint "member_request_type_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_message_sent_at", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["branch_id"], name: "index_member_requests_on_branch_id"
    t.index ["member_request_type_id"], name: "index_member_requests_on_member_request_type_id"
    t.index ["user_id"], name: "index_member_requests_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type"
    t.jsonb "response"
    t.string "object_type"
    t.bigint "object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "read_at"
    t.datetime "responded_at"
    t.index ["object_type", "object_id"], name: "index_notifications_on_object_type_and_object_id"
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["type"], name: "index_notifications_on_type"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.datetime "archived_at"
  end

  create_table "partner_categories", force: :cascade do |t|
    t.string "title"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position"], name: "index_partner_categories_on_position"
  end

  create_table "pgmigrations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "run_on", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_type"
    t.index ["owner_id", "owner_type", "photo_type"], name: "index_photos_on_owner_id_and_owner_type_and_photo_type"
    t.index ["photo_type"], name: "index_photos_on_photo_type"
  end

  create_table "preference_groups", force: :cascade do |t|
    t.string "title"
    t.integer "question_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_ids"], name: "index_preference_groups_on_question_ids", using: :gin
  end

  create_table "profile_requests", force: :cascade do |t|
    t.integer "branch_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id", "user_id"], name: "index_profile_requests_on_branch_id_and_user_id", unique: true
  end

  create_table "question_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.inet "ip_address"
    t.string "user_agent"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_question_versions_on_item_type_and_item_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "category_id"
    t.citext "title"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "locking_conditions", default: [], null: false
    t.boolean "intro", default: false
    t.boolean "allows_note", default: true
    t.string "note_title"
    t.datetime "processed_at"
    t.string "text_style", default: "dark"
    t.boolean "blur_background", default: false
    t.boolean "background_overlay", default: false
    t.index ["allows_note"], name: "index_questions_on_allows_note"
    t.index ["category_id"], name: "index_questions_on_category_id"
    t.index ["intro"], name: "index_questions_on_intro"
    t.index ["kind"], name: "index_questions_on_kind"
    t.index ["processed_at"], name: "index_questions_on_processed_at"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "user_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_ratings_on_branch_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "releases", force: :cascade do |t|
    t.string "file"
    t.string "status", default: "queued"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_assignments", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "staff_member_id"
    t.datetime "archived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archived_at"], name: "index_role_assignments_on_archived_at"
    t.index ["role_id", "staff_member_id", "archived_at"], name: "index_unarchived_staff_member_role"
    t.index ["role_id"], name: "index_role_assignments_on_role_id"
    t.index ["staff_member_id"], name: "index_role_assignments_on_staff_member_id"
  end

  create_table "role_preference_group_assignments", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "preference_group_id"
    t.integer "position"
    t.string "column"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preference_group_id"], name: "index_role_preference_group_assignments_on_preference_group_id"
    t.index ["role_id"], name: "index_role_preference_group_assignments_on_role_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.bigint "business_unit_id"
    t.jsonb "top_questions_data", default: []
    t.string "interactions", array: true
    t.index ["business_unit_id"], name: "index_roles_on_business_unit_id"
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string "name", null: false
    t.string "environment"
    t.text "certificate"
    t.string "password"
    t.integer "connections", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type", null: false
    t.string "auth_key"
    t.string "client_id"
    t.string "client_secret"
    t.string "access_token"
    t.datetime "access_token_expiration"
    t.string "apn_key"
    t.string "apn_key_id"
    t.string "team_id"
    t.string "bundle_id"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string "device_token", limit: 64, null: false
    t.datetime "failed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_id"
    t.index ["device_token"], name: "index_rpush_feedback_on_device_token"
  end

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer "badge"
    t.string "device_token", limit: 64
    t.string "sound"
    t.text "alert"
    t.text "data"
    t.integer "expiry", default: 86400
    t.boolean "delivered", default: false, null: false
    t.datetime "delivered_at"
    t.boolean "failed", default: false, null: false
    t.datetime "failed_at"
    t.integer "error_code"
    t.text "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alert_is_json", default: false, null: false
    t.string "type", null: false
    t.string "collapse_key"
    t.boolean "delay_while_idle", default: false, null: false
    t.text "registration_ids"
    t.integer "app_id", null: false
    t.integer "retries", default: 0
    t.string "uri"
    t.datetime "fail_after"
    t.boolean "processing", default: false, null: false
    t.integer "priority"
    t.text "url_args"
    t.string "category"
    t.boolean "content_available", default: false, null: false
    t.text "notification"
    t.boolean "mutable_content", default: false, null: false
    t.string "external_device_id"
    t.index ["delivered", "failed", "processing", "deliver_after", "created_at"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))"
  end

  create_table "shares", force: :cascade do |t|
    t.integer "branch_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "via"
    t.datetime "requested_at"
    t.datetime "authorised_at"
    t.datetime "denied_at"
    t.datetime "revoked_at"
    t.index ["status"], name: "index_shares_on_status"
    t.index ["via"], name: "index_shares_on_via"
  end

  create_table "staff_assignments", force: :cascade do |t|
    t.bigint "staff_member_id"
    t.string "target_type"
    t.bigint "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.index ["archived_at"], name: "index_staff_assignments_on_archived_at"
    t.index ["staff_member_id", "target_id", "target_type", "archived_at"], name: "index_unarchived_staff_member_target_assignment"
    t.index ["staff_member_id", "target_id", "target_type"], name: "index_staff_member_target_assignment"
    t.index ["staff_member_id"], name: "index_staff_assignments_on_staff_member_id"
    t.index ["target_type", "target_id"], name: "index_staff_assignments_on_target_type_and_target_id"
  end

  create_table "staff_members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "mobile_number"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "authentication_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organisation_id"
    t.string "type"
    t.string "employee_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "suspended_at"
    t.datetime "archived_at"
    t.string "encrypted_pin"
    t.string "unconfirmed_email"
    t.index ["archived_at"], name: "index_staff_members_on_archived_at"
    t.index ["authentication_token"], name: "index_staff_members_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_staff_members_on_confirmation_token", unique: true
    t.index ["email"], name: "index_staff_members_on_email"
    t.index ["employee_id", "organisation_id"], name: "index_staff_members_on_employee_id_and_organisation_id", unique: true
    t.index ["organisation_id"], name: "index_staff_members_on_organisation_id"
    t.index ["reset_password_token"], name: "index_staff_members_on_reset_password_token", unique: true
    t.index ["suspended_at"], name: "index_staff_members_on_suspended_at"
  end

  create_table "user_answer_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.inet "ip_address"
    t.string "user_agent"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_user_answer_versions_on_item_type_and_item_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.text "values"
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.inet "ip_address"
    t.string "user_agent"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_user_versions_on_item_type_and_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "authentication_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "archived_at"
    t.string "first_name"
    t.string "last_name"
    t.string "job_title"
    t.string "company"
    t.string "address"
    t.boolean "onboarding_complete", default: false
    t.string "gender"
    t.jsonb "preferences"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "video_content_categories", force: :cascade do |t|
    t.bigint "video_id"
    t.bigint "content_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_category_id", "video_id"], name: "index_video_categories"
    t.index ["content_category_id"], name: "index_video_content_categories_on_content_category_id"
    t.index ["video_id"], name: "index_video_content_categories_on_video_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "published_at"
    t.bigint "organisation_id"
    t.bigint "vista_admin_id"
    t.integer "notification_job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "published", default: false
    t.datetime "archived_at"
    t.string "platform_id"
    t.index ["organisation_id"], name: "index_videos_on_organisation_id"
    t.index ["published"], name: "index_videos_on_published"
    t.index ["vista_admin_id"], name: "index_videos_on_vista_admin_id"
  end

  create_table "vista_admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_vista_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_vista_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_vista_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_vista_admins_on_unlock_token", unique: true
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "answers", "questions"
  add_foreign_key "branch_categorisations", "branches"
  add_foreign_key "branch_categorisations", "partner_categories"
  add_foreign_key "branches", "business_units"
  add_foreign_key "business_units", "organisations"
  add_foreign_key "category_updates", "categories"
  add_foreign_key "check_ins", "branches"
  add_foreign_key "check_ins", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "ignores", "categories"
  add_foreign_key "ignores", "users"
  add_foreign_key "interactions", "branches"
  add_foreign_key "interactions", "categories"
  add_foreign_key "interactions", "staff_members"
  add_foreign_key "interactions", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "ratings", "branches"
  add_foreign_key "ratings", "users"
  add_foreign_key "role_assignments", "roles"
  add_foreign_key "role_assignments", "staff_members"
  add_foreign_key "role_preference_group_assignments", "preference_groups"
  add_foreign_key "role_preference_group_assignments", "roles"
  add_foreign_key "roles", "business_units"
  add_foreign_key "staff_assignments", "staff_members"
end
