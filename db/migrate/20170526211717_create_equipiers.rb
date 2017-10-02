class CreateEquipiers < ActiveRecord::Migration[5.1]
  def change
    create_table :equipiers do |t|
      t.boolean :conducteur, null: false, default: false
      t.string :nom
      t.string :prenom
      t.string :photo
      t.string :rue
      t.string :cp, limit: 5
      t.string :ville
      t.string :telephone_fixe, limit: 15
      t.string :telephone_portable, limit: 15
      t.string :email
      t.string :profession
      t.date :date_naissance
      t.string :lieu_naissance
      t.string :nationalite
      t.string :permis_conduire_num
      t.string :permis_conduire
      t.string :passeport_num
      t.string :passeport
      t.date :passeport_date_delivrance
      t.string :passeport_lieu_delivrance
      t.date :passeport_date_validite
      t.string :groupe_sanguin, limit: 3
      t.string :nom_prenom_a_prevenir
      t.string :tel_a_prevenir, limit: 15
      t.string :taille_t_shirt, limit: 4
      t.references :equipage, foreign_key: true
      t.references :user

      t.timestamps
    end
  end
end
