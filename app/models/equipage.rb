class Equipage < ApplicationRecord
  include Commun

  has_many :equipiers
  belongs_to :user

  acts_as_xlsx

  # Recherche les objets avec une référence ou une désignation contenant le mot-clé recherché
  def self.contenant(terme)
    terme = full_text(terme)

    joins(:equipiers).
    where("numero LIKE ? OR immatriculation LIKE ? OR equipiers.nom LIKE ? OR equipiers.prenom LIKE ?", terme, terme, terme, terme)
  end

  # Recherche les objets relatifs à la recherche (passée en paramètre)
  def self.filtre_par(terme)
    select("*").
    order(id: :desc).
    contenant(terme)
  end

end
