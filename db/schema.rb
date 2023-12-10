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

ActiveRecord::Schema[7.0].define(version: 2023_12_10_191115) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "behaviour", ["stubborn", "gentle"]
  create_enum "book_genre", ["Prayer books", "Childrens", "Travel", "Romance", "Cookbooks", "Self help", "Drama", "Math", "Religion-Spirituality", "Anthology", "Trilogy", "Autobiographies", "Mystery", "Diaries", "Journals", "History", "Art", "Dictionaries", "Horror", "Encyclopedias", "Action and Adventure", "Fantasy", "Comics", "Science fiction", "Series", "Guide", "Biographies", "Health", "Satire", "Science", "Poetry"]
  create_enum "career", ["Database Developer", "Portal Administrator", "Systems Security Administrator", "Business Systems Analyst", "Software Systems Engineer", "Business Intelligence Analyst", "CRM Technical Developer", "Mobile Applications Developer", "UX Designer", "Quality Assurance Associate", "Web Developer", "Information Security Analyst", "CRM Business Analyst", "Technical Support", "Project Manager", "Information Technology Manager", "Programmer Analyst", "Design & UX", "Solutions Architect", "Systems Analyst", "Network Security Administrator", "Data Architect", "Software Developer", "E-Commerce Analyst", "Technical Services/Help Desk/Tech Support", "Information Technology Auditor", "Database Manager", "Applications Developer", "Database Administrator", "Network Engineer", "Software Engineer", "Technical Engineer", "Network Security Engineer", "Software Quality Assurance (QA) / Testing"]
  create_enum "interested_subject", ["cloud computing", "networks", "hacking", "Computer Architecture", "programming", "parallel computing", "IOT", "data engineering", "Software Engineering", "Management"]
  create_enum "management_technical", ["Management", "Technical"]
  create_enum "quality", ["excellent", "poor", "medium"]
  create_enum "salary_work", ["salary", "work"]
  create_enum "worker_type", ["hard worker", "smart worker"]
  create_enum "yes_no", ["yes", "no"]

  create_table "emerging_jobs", force: :cascade do |t|
    t.string "name", null: false
    t.string "industry", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
  end

  create_table "emerging_jobs_skills", force: :cascade do |t|
    t.bigint "emerging_job_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emerging_job_id"], name: "index_emerging_jobs_skills_on_emerging_job_id"
    t.index ["skill_id"], name: "index_emerging_jobs_skills_on_skill_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "working_hours", null: false
    t.integer "public_speaking_points", null: false
    t.enum "self_learning", null: false, enum_type: "yes_no"
    t.enum "extra_courses", null: false, enum_type: "yes_no"
    t.enum "plays_games", null: false, enum_type: "yes_no"
    t.enum "team_player", null: false, enum_type: "yes_no"
    t.enum "introvert", null: false, enum_type: "yes_no"
    t.enum "reading_writing_skills", null: false, enum_type: "quality"
    t.enum "memory_capability", null: false, enum_type: "quality"
    t.enum "interested_subject", null: false, enum_type: "interested_subject"
    t.enum "fav_book_genre", null: false, enum_type: "book_genre"
    t.enum "behaviour", null: false, enum_type: "behaviour"
    t.enum "management_technical", null: false, enum_type: "management_technical"
    t.enum "salary_work", null: false, enum_type: "salary_work"
    t.enum "worker_type", null: false, enum_type: "worker_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "career", enum_type: "career"
    t.bigint "emerging_job_id"
    t.index ["emerging_job_id"], name: "index_users_on_emerging_job_id"
  end

  create_table "users_lacking_skills", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_users_lacking_skills_on_skill_id"
    t.index ["user_id"], name: "index_users_lacking_skills_on_user_id"
  end

  create_table "users_skills", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_users_skills_on_skill_id"
    t.index ["user_id"], name: "index_users_skills_on_user_id"
  end

  add_foreign_key "emerging_jobs_skills", "emerging_jobs"
  add_foreign_key "emerging_jobs_skills", "skills"
  add_foreign_key "profiles", "users"
  add_foreign_key "users", "emerging_jobs"
  add_foreign_key "users_lacking_skills", "skills"
  add_foreign_key "users_lacking_skills", "users"
  add_foreign_key "users_skills", "skills"
  add_foreign_key "users_skills", "users"
end
