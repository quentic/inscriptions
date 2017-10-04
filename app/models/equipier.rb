class Equipier < ApplicationRecord
  include Commun

  belongs_to :equipage
  belongs_to :user
  
  mount_uploader :photo, PhotoUploader
  mount_uploader :permis_conduire, PermisConduireUploader
  mount_uploader :passeport, PasseportUploader
  
  before_save :nom_en_majuscules, :prenom_avec_initiale_maj

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

protected

  def nom_en_majuscules
    self.nom = nom.upcase
  end

  def prenom_avec_initiale_maj
    self.prenom = prenom.capitalize
  end

end
