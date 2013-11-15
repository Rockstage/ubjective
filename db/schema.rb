# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131115123640) do

  create_table "authentications", :force => true do |t|
    t.string   "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "token_secret"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "expertises", :force => true do |t|
    t.integer  "user_id"
    t.integer  "specialty_id"
    t.string   "expertise"
    t.text     "details"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "expertises", ["specialty_id"], :name => "index_expertises_on_specialty_id"
  add_index "expertises", ["user_id"], :name => "index_expertises_on_user_id"

  create_table "objectives", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.text     "objective"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "completed",  :default => false
    t.integer  "position"
  end

  add_index "objectives", ["task_id"], :name => "index_objectives_on_task_id"
  add_index "objectives", ["user_id"], :name => "index_objectives_on_user_id"

  create_table "projects", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "mission"
    t.text     "description"
    t.string   "location"
    t.string   "category"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "vision"
    t.string   "status"
    t.boolean  "public",      :default => false
  end

  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "skills", :force => true do |t|
    t.integer  "user_id"
    t.integer  "specialty_id"
    t.integer  "expertise_id"
    t.string   "skill"
    t.integer  "skill_lvl"
    t.text     "description"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "skills", ["expertise_id"], :name => "index_skills_on_expertise_id"
  add_index "skills", ["specialty_id"], :name => "index_skills_on_specialty_id"
  add_index "skills", ["user_id"], :name => "index_skills_on_user_id"

  create_table "specialties", :force => true do |t|
    t.integer  "user_id"
    t.string   "specialty"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "specialties", ["user_id"], :name => "index_specialties_on_user_id"

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "public",      :default => false
    t.string   "author"
  end

  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "user_educations", :force => true do |t|
    t.integer  "user_id"
    t.string   "institution"
    t.string   "edu_level"
    t.string   "edu_field"
    t.date     "edu_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_educations", ["user_id"], :name => "index_user_educations_on_user_id"

  create_table "user_languages", :force => true do |t|
    t.integer  "user_id"
    t.string   "language"
    t.string   "skill_level"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_languages", ["user_id"], :name => "index_user_languages_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_name"
    t.string   "role"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.datetime "birthday"
    t.string   "gender"
    t.string   "location"
    t.string   "contact"
    t.text     "personal_goal"
    t.text     "pro_goal"
    t.text     "interests"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
