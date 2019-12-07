class AddCarteGriseToEquipages < ActiveRecord::Migration[5.1]
  def change
    add_column :equipages, :carte_grise, :string
  end
end
