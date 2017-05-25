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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170509130801) do

  create_table "a_facturer_entites", force: :cascade do |t|
    t.string "nom",     limit: 255
    t.string "contrat", limit: 10,  default: "MAAF"
  end

  add_index "a_facturer_entites", ["contrat"], name: "index_a_facturer_entites_on_contrat", using: :btree

  create_table "campagnes", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.integer  "demandeur_id",          limit: 4
    t.integer  "a_facturer_entite_id",  limit: 4
    t.integer  "client_centre_cout_id", limit: 4
    t.integer  "code_projet",           limit: 4
    t.string   "libelle",               limit: 255
    t.string   "ref_interne_xerox",     limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "contrat",               limit: 10,  default: "MAAF"
  end

  add_index "campagnes", ["a_facturer_entite_id"], name: "index_campagnes_on_a_facturer_entite_id", using: :btree
  add_index "campagnes", ["client_centre_cout_id"], name: "index_campagnes_on_client_centre_cout_id", using: :btree
  add_index "campagnes", ["contrat"], name: "index_campagnes_on_contrat", using: :btree
  add_index "campagnes", ["demandeur_id"], name: "index_campagnes_on_demandeur_id", using: :btree
  add_index "campagnes", ["libelle", "ref_interne_xerox"], name: "index_campagnes_on_libelle_and_ref_interne_xerox", unique: true, using: :btree
  add_index "campagnes", ["user_id"], name: "index_campagnes_on_user_id", using: :btree

  create_table "client_centre_couts", force: :cascade do |t|
    t.string "libelle", limit: 255
    t.string "contrat", limit: 10,  default: "MAAF"
  end

  add_index "client_centre_couts", ["contrat"], name: "index_client_centre_couts_on_contrat", using: :btree

  create_table "commodites", force: :cascade do |t|
    t.string "libelle", limit: 255
  end

  create_table "demandeurs", force: :cascade do |t|
    t.boolean "xerox",   limit: 1,     default: false,  null: false
    t.string  "prenom",  limit: 255
    t.string  "nom",     limit: 255
    t.text    "adresse", limit: 65535
    t.string  "email",   limit: 50
    t.string  "contrat", limit: 10,    default: "MAAF"
  end

  add_index "demandeurs", ["contrat"], name: "index_demandeurs_on_contrat", using: :btree

  create_table "details", force: :cascade do |t|
    t.integer  "element_id",       limit: 4
    t.integer  "rang",             limit: 4
    t.string   "libelle_ligne_da", limit: 255
    t.integer  "presta_type_id",   limit: 4
    t.string   "format_ouvert",    limit: 255
    t.string   "format_ferme",     limit: 255
    t.integer  "quantite",         limit: 4
    t.integer  "nb_pages",         limit: 4
    t.string   "papier_type",      limit: 255
    t.string   "couleur",          limit: 255
    t.integer  "finition_id",      limit: 4
    t.text     "spec_detaillees",  limit: 65535
    t.string   "doc",              limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "packaging",        limit: 255
  end

  add_index "details", ["element_id"], name: "index_taches_on_element_id", using: :btree
  add_index "details", ["finition_id"], name: "index_taches_on_finition_id", using: :btree
  add_index "details", ["presta_type_id"], name: "index_taches_on_presta_type_id", using: :btree

  create_table "elements", force: :cascade do |t|
    t.integer  "user_id",                      limit: 4,                           default: 2, null: false
    t.integer  "campagne_id",                  limit: 4
    t.integer  "etat_dossier",                 limit: 4,                                       null: false
    t.string   "num_facture_xerox",            limit: 14
    t.date     "date_facturation_xerox"
    t.integer  "commodite_id",                 limit: 4
    t.string   "commentaire",                  limit: 255
    t.integer  "markup",                       limit: 4
    t.decimal  "taux_tva",                                 precision: 5, scale: 2
    t.string   "numero_po_client",             limit: 255
    t.date     "date_max_input_fournisseur"
    t.date     "date_max_output_fournisseur"
    t.date     "date_reelle_livraison_client"
    t.date     "date_reception_bordereau"
    t.string   "num_po_xerox",                 limit: 255
    t.string   "num_facture_fournisseur",      limit: 255
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
    t.date     "date_promesse_client"
    t.boolean  "ens1",                         limit: 1
    t.boolean  "ens2",                         limit: 1
    t.boolean  "ens4",                         limit: 1
    t.boolean  "ens5",                         limit: 1
    t.date     "date_max_input_client"
    t.date     "date_max_livraison_client"
    t.integer  "fournisseur1_id",              limit: 4
    t.integer  "fournisseur2_id",              limit: 4
    t.integer  "fournisseur3_id",              limit: 4
    t.integer  "fournisseur_choisi_id",        limit: 4
  end

  add_index "elements", ["campagne_id"], name: "index_elements_on_campagne_id", using: :btree
  add_index "elements", ["commodite_id"], name: "index_elements_on_commodite_id", using: :btree
  add_index "elements", ["fournisseur1_id"], name: "fk_rails_51422c9e41", using: :btree
  add_index "elements", ["fournisseur2_id"], name: "fk_rails_1adfbe9aa0", using: :btree
  add_index "elements", ["fournisseur3_id"], name: "fk_rails_7cd0c080bd", using: :btree
  add_index "elements", ["fournisseur_choisi_id"], name: "fk_rails_be8e19efd3", using: :btree
  add_index "elements", ["user_id"], name: "index_elements_on_user_id", using: :btree

  create_table "elements_livraison_points", force: :cascade do |t|
    t.integer "element_id",         limit: 4
    t.integer "livraison_point_id", limit: 4
    t.integer "quantite",           limit: 4
    t.text    "commentaire",        limit: 65535
  end

  add_index "elements_livraison_points", ["element_id"], name: "index_elements_livraison_points_on_element_id", using: :btree
  add_index "elements_livraison_points", ["livraison_point_id"], name: "index_elements_livraison_points_on_livraison_point_id", using: :btree

  create_table "finitions", force: :cascade do |t|
    t.string "libelle", limit: 255, null: false
  end

  add_index "finitions", ["libelle"], name: "index_finitions_on_libelle", unique: true, using: :btree

  create_table "fournisseurs", force: :cascade do |t|
    t.string  "nom",                           limit: 255
    t.text    "adresse",                       limit: 65535
    t.string  "contact",                       limit: 255
    t.string  "email",                         limit: 255
    t.string  "tel_fixe",                      limit: 255
    t.string  "tel_portable",                  limit: 255
    t.text    "commentaire",                   limit: 65535
    t.boolean "famille_impression_roto",       limit: 1
    t.boolean "famille_impression_feuille",    limit: 1
    t.boolean "famille_serigraphie_numerique", limit: 1
    t.boolean "famille_routage",               limit: 1
    t.boolean "famille_enveloppes",            limit: 1
    t.boolean "famille_matieres",              limit: 1
    t.boolean "famille_autre",                 limit: 1
  end

  add_index "fournisseurs", ["nom"], name: "nom", unique: true, using: :btree

  create_table "la_source", id: false, force: :cascade do |t|
    t.string  "bidon1",                                                        limit: 255,                            null: false
    t.string  "etat_dossier",                                                  limit: 255,                            null: false
    t.string  "etat_po",                                                       limit: 255,                            null: false
    t.string  "ref_interne_xerox",                                             limit: 255,                            null: false
    t.string  "CP",                                                            limit: 255,                            null: false
    t.integer "ligne_num",                                                     limit: 4,                              null: false
    t.string  "num_facture_xerox",                                             limit: 255,                            null: false
    t.date    "date_facturation",                                                                                     null: false
    t.string  "nom de de la campagne",                                         limit: 255,                            null: false
    t.string  "Commodité",                                                     limit: 255,                            null: false
    t.string  "presta_type",                                                   limit: 255,                            null: false
    t.string  "libelle_ligne_da",                                              limit: 255,                            null: false
    t.integer "quantite",                                                      limit: 4,                              null: false
    t.string  "commentaire",                                                   limit: 255,                            null: false
    t.string  "format ouvert",                                                 limit: 255,                            null: false
    t.string  "format ferme",                                                  limit: 255,                            null: false
    t.integer "Pages",                                                         limit: 4,                              null: false
    t.string  "Couleur",                                                       limit: 255,                            null: false
    t.string  "papier_type",                                                   limit: 255,                            null: false
    t.string  "Finition",                                                      limit: 255,                            null: false
    t.string  "Packaging",                                                     limit: 255,                            null: false
    t.text    "spécifications Détaillées",                                     limit: 65535,                          null: false
    t.text    "Point de livraison",                                            limit: 65535,                          null: false
    t.string  "nom du demandeur",                                              limit: 255,                            null: false
    t.string  "Entité à facturer",                                             limit: 255,                            null: false
    t.string  "Centre cout Client",                                            limit: 255,                            null: false
    t.date    "date de réception du brief",                                                                           null: false
    t.date    "date de livraison demandée du produit final v INTERNE",                                                null: false
    t.decimal "prix HT du fournisseur 1",                                                    precision: 10, scale: 2, null: false
    t.string  "fournisseur 1",                                                 limit: 255,                            null: false
    t.decimal "prix HT du fournisseur 2",                                                    precision: 10, scale: 2, null: false
    t.string  "fournisseur 2",                                                 limit: 255,                            null: false
    t.decimal "prix HT du fournisseur 3",                                                    precision: 10, scale: 2, null: false
    t.string  "fournisseur 3",                                                 limit: 255,                            null: false
    t.string  "fournisseur choisi",                                            limit: 255,                            null: false
    t.string  "bidon 99",                                                      limit: 255,                            null: false
    t.decimal "markup",                                                                      precision: 52,           null: false
    t.decimal "bidon 100",                                                                   precision: 52,           null: false
    t.decimal "Taux de TVA",                                                                 precision: 52,           null: false
    t.decimal "bidon 101",                                                                   precision: 52,           null: false
    t.decimal "bidon 102",                                                                   precision: 52,           null: false
    t.string  "Raison pour une absence de marge",                              limit: 255,                            null: false
    t.string  "bidon 103",                                                     limit: 255,                            null: false
    t.string  "bidon 104",                                                     limit: 255,                            null: false
    t.date    "date de remise du devis à MAAF",                                                                       null: false
    t.date    "date de validation client",                                                                            null: false
    t.string  "numéro PO MAAF",                                                limit: 255,                            null: false
    t.date    "Date prévisionnelle de remise du fichier au fournisseur",                                              null: false
    t.date    "DATE BUTOIR DE LIVRAISON (vue du fournisseur)",                                                        null: false
    t.date    "date actuel de livraison",                                                                             null: false
    t.integer "ENS1",                                                          limit: 4,                              null: false
    t.integer "ENS2",                                                          limit: 4,                              null: false
    t.integer "ENS3",                                                          limit: 4,                              null: false
    t.integer "ENS4",                                                          limit: 4,                              null: false
    t.integer "ENS5",                                                          limit: 4,                              null: false
    t.string  "Supplier Non-conformance",                                      limit: 255,                            null: false
    t.string  "numéro du PO xerox",                                            limit: 255,                            null: false
    t.string  "bidon 105",                                                     limit: 255,                            null: false
    t.date    "date de reception du bordereau de livraison",                                                          null: false
    t.string  "numéro de facture fournisseur",                                 limit: 255,                            null: false
    t.string  "mois de facturation prévi du client",                           limit: 255,                            null: false
    t.string  "Job assimilable au panier de référence ou grille de référence", limit: 255,                            null: false
    t.string  "Reference de calcul",                                           limit: 255,                            null: false
    t.string  "prix de référence ramené au volume actuel TTC",                 limit: 255,                            null: false
    t.string  "bidon 106",                                                     limit: 255,                            null: false
    t.string  "bidon 107",                                                     limit: 255,                            null: false
    t.text    "commentaires",                                                  limit: 65535,                          null: false
  end

  create_table "livraison_points", force: :cascade do |t|
    t.text   "nom",          limit: 65535,                  null: false
    t.text   "rue",          limit: 65535
    t.string "cp",           limit: 5
    t.string "ville",        limit: 255
    t.string "telephone",    limit: 15
    t.string "commentaires", limit: 255
    t.string "contrat",      limit: 10,    default: "MAAF"
  end

  add_index "livraison_points", ["contrat"], name: "index_livraison_points_on_contrat", using: :btree
  add_index "livraison_points", ["nom"], name: "nom", unique: true, length: {"nom"=>30}, using: :btree

  create_table "offres", force: :cascade do |t|
    t.integer  "detail_id",      limit: 4
    t.integer  "fournisseur_id", limit: 4
    t.decimal  "prix_ht",                  precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offres", ["detail_id"], name: "detail_id", using: :btree
  add_index "offres", ["fournisseur_id"], name: "fournisseur_id", using: :btree

  create_table "presta_types", force: :cascade do |t|
    t.string  "libelle",      limit: 255
    t.integer "commodite_id", limit: 4
  end

  add_index "presta_types", ["commodite_id"], name: "index_presta_types_on_commodite_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "prenom",                 limit: 255
    t.string   "nom",                    limit: 255
    t.boolean  "admin",                  limit: 1,   default: false
    t.boolean  "campagne_manager",       limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "details", "elements"
  add_foreign_key "details", "finitions"
  add_foreign_key "details", "presta_types"
  add_foreign_key "elements", "campagnes", name: "elements_ibfk_1", on_delete: :cascade
  add_foreign_key "elements", "fournisseurs", column: "fournisseur1_id"
  add_foreign_key "elements", "fournisseurs", column: "fournisseur2_id"
  add_foreign_key "elements", "fournisseurs", column: "fournisseur3_id"
  add_foreign_key "elements", "fournisseurs", column: "fournisseur_choisi_id"
  add_foreign_key "offres", "details", name: "offres_ibfk_2", on_delete: :cascade
  add_foreign_key "offres", "fournisseurs", name: "offres_ibfk_3"
  add_foreign_key "presta_types", "commodites", on_delete: :cascade
end
