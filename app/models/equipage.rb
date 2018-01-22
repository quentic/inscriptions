class Equipage < ApplicationRecord
  include Commun

  has_many :equipiers, dependent: :destroy
  belongs_to :user

  acts_as_xlsx

  validates :numero, uniqueness: {message: " : ce numéro d'équipage est déjà réservé ! <br \>Choisissez-en un autre ou contactez Aline"}

  # Recherche les objets avec une référence ou une désignation contenant le mot-clé recherché
  def self.contenant(terme)
    terme = full_text(terme)

    joins(:equipiers).
    where("numero LIKE ? OR immatriculation LIKE ? OR equipiers.nom LIKE ? OR equipiers.prenom LIKE ?", terme, terme, terme, terme)
  end

  # Recherche les objets relatifs à la recherche (passée en paramètre)
  def self.filtre_par(terme)
    order(id: :desc).
    contenant(terme).
    group(:id)
  end

  def self.tous
    all.avec_equipiers
  end
	
  def self.avec_equipiers
    select(:id).
    select("max(numero) AS numero").
    select("max(conducteur.prenom)").select("max(conducteur.nom)").
    select("max(passager.prenom)").select("max(passager.nom)").
    joins("LEFT JOIN equipiers conducteur ON conducteur.equipage_id = equipages.id AND conducteur.conducteur").
    joins("LEFT JOIN equipiers passager ON passager.equipage_id = equipages.id AND NOT passager.conducteur").
    group(:id).
    order(:numero).
    order("max(conducteur.nom)")
  end

  def self.avec_numero_ou_conducteur
    select("*").
    includes(:equipiers).
    where("equipages.numero IS NOT NULL OR equipiers.conducteur OR equipiers.id IS NULL").
    order(:numero).
    order("equipiers.nom")
  end

  def self.avec_equipiers_csv
    select("equipages.*").
    select("equipiers.*").
    joins("LEFT JOIN equipiers ON equipiers.equipage_id = equipages.id").
    order(numero: :asc)
  end



end
