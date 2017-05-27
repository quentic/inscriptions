class Equipage < ApplicationRecord
  include Commun

  has_many :equipiers

  # Recherche les objets avec une référence ou une désignation contenant le mot-clé recherché
  def self.contenant(terme)
    terme = full_text(terme)

    where("nom LIKE ?", terme)
  end

  # Recherche les objets relatifs à la recherche (passée en paramètre)
  def self.filtre_par(terme)
    select("*").
    order(id: :desc).
    contenant(terme)
  end

end
