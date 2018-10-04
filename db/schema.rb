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

ActiveRecord::Schema.define(version: 2018_10_02_182910) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "image_info", primary_key: "image_idx", id: :integer, comment: "이미지ID", unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "이미지 정보", force: :cascade do |t|
    t.string "image_url", limit: 1000, null: false, comment: "unique 제약조건 걸림"
    t.string "search_keyword", limit: 30, null: false, comment: "검색키워드"
    t.datetime "crawling_date", null: false, comment: "크롤링 한 날짜"
    t.float "similarity", default: 0.0, null: false, comment: "유사도"
    t.integer "status", limit: 1, default: 0, null: false, comment: "수집 완료 : 0 유사도 검증 후 저장함 : 1 유사도 낮아서 삭제 : 2"
    t.integer "img_type", limit: 1, null: false, comment: "트립 어드바이저: 0 인스타 : 1"
    t.integer "insta_data_id", comment: "인스타 데이터 ID", unsigned: true
    t.integer "trip_idx", comment: "트립 데이터 ID", unsigned: true
    t.string "file_address", limit: 100, comment: "파일명과 저장된 위치"
    t.index ["image_url"], name: "UIX_image_info", unique: true
    t.index ["insta_data_id"], name: "FK_insta_metadata_TO_image_info"
    t.index ["trip_idx"], name: "FK_trip_metadata_TO_image_info"
  end

  create_table "insta_hashtag", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "해시태그", force: :cascade do |t|
    t.integer "insta_data_id", comment: "인스타 데이터 ID", unsigned: true
    t.string "insta_hashtag", limit: 50, comment: "해시태그"
    t.index ["insta_data_id"], name: "FK_insta_metadata_TO_insta_hashtag"
  end

  create_table "insta_metadata", primary_key: "insta_data_id", id: :integer, comment: "인스타 데이터 ID", unsigned: true, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "인스타그램 메타데이터", force: :cascade do |t|
    t.string "insta_location", limit: 100, comment: "업로드 위치"
  end

  create_table "similarity_param", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "유사도판별 파라미터 기록", force: :cascade do |t|
    t.integer "positive_img_count", null: false, comment: "유사한 이미지 숫자", unsigned: true
    t.integer "negative_img_count", null: false, comment: "유사하지 않은 이미지 수", unsigned: true
    t.integer "total_img_count", null: false, comment: "전체 저장한 이미지 수", unsigned: true
  end

  create_table "test", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "idx"
  end

  create_table "trip_metadata", primary_key: "trip_idx", id: :integer, comment: "트립 데이터 ID", unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "트립어드바이저 메타데이터", force: :cascade do |t|
    t.string "trip_review_url", limit: 1000, comment: "리뷰 원본 URL"
    t.string "trip_gallery_id", limit: 100, comment: "갤러리 고유 url"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "image_info", "insta_metadata", column: "insta_data_id", primary_key: "insta_data_id", name: "FK_insta_metadata_TO_image_info"
  add_foreign_key "image_info", "trip_metadata", column: "trip_idx", primary_key: "trip_idx", name: "FK_trip_metadata_TO_image_info"
  add_foreign_key "insta_hashtag", "insta_metadata", column: "insta_data_id", primary_key: "insta_data_id", name: "FK_insta_metadata_TO_insta_hashtag"
end
