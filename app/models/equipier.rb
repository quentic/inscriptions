class Equipier < ApplicationRecord
  include Commun

  belongs_to :equipage
  belongs_to :user
  
  validates_uniqueness_of :passeport_num

  mount_uploader :photo, PhotoUploader
  mount_uploader :permis_conduire, PermisConduireUploader
  mount_uploader :passeport, PasseportUploader
  
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
  
  def self.conducteur
   where(conducteur: true)
  end

  def self.passager
    where(conducteur: false)
  end

  def prenom_nom
    self.prenom + " " + self.nom
  end

end
