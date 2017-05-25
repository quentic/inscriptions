# Des méthodes pour travailler sur les fichiers PDF
class FichierPdf < Fichier

  attr_reader :ref_pdf
  # Constructeur de la classe FichierPdf
  #
  # Paramètres :
  # - ref_pdf : nom du fichier PDF (sans extension)
  # - prefixe : prefixe à ajouter en tête du nom de fichier (optionnel)
  # - hote : hote de l'URL d'appel (permet de construire les URL en fonction du réseau de l'utilisateur)
  def initialize(ref_pdf, prefixe, hote)
    super(ref_pdf, prefixe, hote) # on hérite des méthodes de la classe Fichier

    @ref_fichier = File.basename(@ref_fichier, ".pdf") # Supprime l'extension
    @ref_pdf = @ref_fichier
  end

  # Extrait les metadonnées du PDF et renvoie le nombre de pages
  def recup_nbpages
    PDF::Toolkit.open(@chemin).page_count
  end

end
