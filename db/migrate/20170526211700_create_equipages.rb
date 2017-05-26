class CreateEquipages < ActiveRecord::Migration[5.1]
  def change
    create_table :equipages do |t|
      t.string :type_puissance
      t.string :carte_grise_titulaire
      t.date :carte_grise_date_emission
      t.date :premiere_mise_en_circ
      t.string :immatriculation
      t.string :string
      t.string :cie_assurance

      t.timestamps
    end
  end
end
