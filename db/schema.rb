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

ActiveRecord::Schema[7.0].define(version: 2023_04_29_104046) do
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

  create_table "users", force: :cascade do |t|
    t.integer "working_hours"
    t.integer "public_speaking_points"
    t.boolean "self_learning"
    t.boolean "extra_courses"
    t.boolean "plays_games"
    t.boolean "team_player"
    t.boolean "introvert"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "reading_writing_skills", enum_type: "quality"
    t.enum "memory_capability", enum_type: "quality"
    t.enum "interested_subject", enum_type: "interested_subject"
    t.enum "fav_book_genre", enum_type: "book_genre"
    t.enum "behaviour", enum_type: "behaviour"
    t.enum "management_technical", enum_type: "management_technical"
    t.enum "salary_work", enum_type: "salary_work"
    t.enum "worker_type", enum_type: "worker_type"
    t.enum "career", enum_type: "career"
  end

end
