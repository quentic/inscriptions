class CreateEquipages < ActiveRecord::Migration[5.1]
  def change
    create_table :equipages do |t|
      t.integer :numero, limit: 2
      t.string :type_puissance, limit: 20
      t.string :carte_grise_titulaire
      t.date :carte_grise_date_emission
      t.date :premiere_mise_en_circ
      t.string :immatriculation, limit: 15
      t.string :cie_assurance
      t.references :user

      t.timestamps
    end
    add_index :equipages, :numero, unique: true
  end
end
