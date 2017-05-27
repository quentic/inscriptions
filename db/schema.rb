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

ActiveRecord::Schema.define(version: 20170526211717) do

  create_table "equipages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "type_puissance", limit: 20
    t.string "carte_grise_titulaire"
    t.date "carte_grise_date_emission"
    t.date "premiere_mise_en_circ"
    t.string "immatriculation", limit: 15
    t.string "cie_assurance"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_equipages_on_user_id"
  end

  create_table "equipiers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "nom"
    t.string "prenom"
    t.string "rue"
    t.string "cp", limit: 5
    t.string "ville"
    t.string "telephone_fixe", limit: 15
    t.string "telephone_portable", limit: 15
    t.string "email"
    t.string "profession"
    t.date "date_naissance"
    t.string "lieu_naissance"
    t.string "nationalite"
    t.string "num_permis_conduire"
    t.string "passeport_num"
    t.date "passeport_date_delivrance"
    t.string "passeport_lieu_delivrance"
    t.date "passeport_date_validite"
    t.string "groupe_sanguin", limit: 3
    t.string "nom_prenom_a_prevenir"
    t.string "tel_a_prevenir", limit: 15
    t.string "taille_t_shirt", limit: 4
    t.bigint "equipage_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipage_id"], name: "index_equipiers_on_equipage_id"
    t.index ["user_id"], name: "index_equipiers_on_user_id"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "login"
    t.string "email", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "prenom"
    t.string "nom"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.boolean "admin", default: false, null: false
    t.boolean "voit_tout", default: false, null: false
    t.string "salt", limit: 40
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "inscription_manager", default: false, null: false
  end

  add_foreign_key "equipiers", "equipages"
end
