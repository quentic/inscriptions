class Equipier < ApplicationRecord
  include Commun

  belongs_to :equipage
  belongs_to :user
  
  validates_uniqueness_of :passeport_num

  # On ajoute photo_doc, permis_conduire_doc et passeport_doc au modèle bien qu'il ne soit pas dans les champs la table equipiers.
  # Cela permet de récupérer le contenu du fichier dans le modèle (par défaut, il n'est accessible que dans le controleur)
  attr_accessor :photo_doc
  attr_accessor :permis_conduire_doc
  attr_accessor :passeport_doc

  before_save :enregistrer_photo, :enregistrer_permis_conduire, :enregistrer_passeport
  
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

private

  def enregistrer_photo
    return if photo_doc.nil?

    fichier = Fichier.new(photo_doc.original_filename)
    nom_fichier = fichier.ref_fichier_sans_extension + rand(10000).to_s + "." + fichier.extension
    # on n'enregistre que le nom du fichier dans la base
    self.photo = nom_fichier 

    chemin_fichier = "public/images/#{equipage.id}/#{nom_fichier}"
    
    # on enregistre le fichier dans l'arborescence de fichiers de l'appli
    publier(photo_doc, chemin_fichier)
  end
    
  def enregistrer_permis_conduire
    return if permis_conduire_doc.nil?

    fichier = Fichier.new(permis_conduire_doc.original_filename)
    nom_fichier = fichier.ref_fichier_sans_extension + rand(10000).to_s + fichier.extension
    # on n'enregistre que le nom du fichier dans la base
    self.permis_conduire = nom_fichier 

    chemin_fichier = "public/images/#{equipage.id}/#{nom_fichier}"
    
    # on enregistre le fichier dans l'arborescence de fichiers de l'appli
    publier(permis_conduire_doc, chemin_fichier)
  end

  def enregistrer_passeport
    return if passeport_doc.nil?

    fichier = Fichier.new(passeport_doc.original_filename)
    nom_fichier = fichier.ref_fichier_sans_extension + rand(10000).to_s + fichier.extension
    # on n'enregistre que le nom du fichier dans la base
    self.passeport = nom_fichier 

    chemin_fichier = "public/images/#{equipage.id}/#{nom_fichier}"
    
    # on enregistre le fichier dans l'arborescence de fichiers de l'appli
    publier(passeport_doc, chemin_fichier)
  end

  # enregistre le document téléversé dans l'espace de publication
  def publier(doc, chemin_fichier)
    Fichier.new(chemin_fichier).cree_dossier_si_nexiste_pas
    File.open(chemin_fichier, "wb", 0744) { |f|
      f.write(doc.read)
    }
    
  rescue
    raise "Document non enregistré"
  
  end

end
