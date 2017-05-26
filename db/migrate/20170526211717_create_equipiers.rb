class CreateEquipiers < ActiveRecord::Migration[5.1]
  def change
    create_table :equipiers do |t|
      t.string :nom
      t.string :prenom
      t.string :rue
      t.string :cp
      t.string :ville
      t.string :telephone_fixe
      t.string :telephone_portable
      t.string :email
      t.string :profession
      t.string :date_naissance
      t.string :date
      t.string :lieu_naissance
      t.string :nationalite
      t.string :num_permis_conduire
      t.string :passeport_num
      t.date :passeport_date_delivrance
      t.string :passeport_lieu_delivrance
      t.date :passeport_date_validite
      t.string :groupe_sanguin
      t.string :nom_prenom_a_prevenir
      t.string :tel_a_prevenir
      t.references :equipage, foreign_key: true

      t.timestamps
    end
  end
end
