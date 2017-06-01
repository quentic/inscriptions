#encoding: utf-8
# Regroupement des outils pour travailler sur les fichiers (sur serveur RoR et autres espaces de stockage)
# - La classe Fichier est générique

# Des méthodes pour travailler sur les fichiers
class Fichier
  attr_reader :ref_fichier
  attr_reader :ref_fichier_sans_extension
  attr_reader :extension
  attr_accessor :chemin
  attr_reader :rimage
  attr_reader :prefixe
  attr_reader :hote

  def initialize(ref_fichier, prefixe="", hote="")
    @ref_fichier = (ref_fichier.blank? ? "sans_nom" : ref_fichier.delete(" "))
    @chemin = @ref_fichier
    @ref_fichier = File.basename(@ref_fichier) # Ne conserve que le nom du fichier sans le chemin
    @ref_fichier_sans_extension = File.basename(@ref_fichier, ".*") # supprime l'extension
    @extension = File.extname(@ref_fichier).strip.downcase

    @prefixe = prefixe.to_s

    @hote = hote
  end

  # Fournit le chemin d'accès à un fichier en fonction du type de fichier fourni en paramètre
  #
  # Les espaces dans les noms de fichiers sont supprimés dans Bibli_pdf
  def path_to_file(type_acces)
    case type_acces
    when "racine_site" # Fichier à la racine du site
      "#{Rails.root}/#{@ref_fichier}"
    end
  end

  # Detruit le fichier et le dossier correspondant s'il est vide
  def detruit_fichier_et_dossier_si_vide
    ref_fichier_dans_referentiel = @chemin

    if File.exist?(ref_fichier_dans_referentiel)
      File.unlink(ref_fichier_dans_referentiel)
      Rails.logger.warn("*** Fichier PDF supprimé le #{Time.new} :" +  ref_fichier_dans_referentiel)
    end

    begin
      dossier_a_detruire = File.dirname(ref_fichier_dans_referentiel)
      Dir.delete(dossier_a_detruire)
    rescue
      # Le dossier n'est pas vide
      Rails.logger.warn("*** Dossier non vide : " +  dossier_a_detruire)
    else
      # Le dossier est vide : on vient de le supprimer
      Rails.logger.warn("*** Dossier supprimé le #{Time.new} : " +  dossier_a_detruire)
    end
  end

  # Change l'extension du nom du fichier
  def change_extension(fichier, extension)
    fichier[0..-5] + "." + extension
  end

  # Crée un dossier s'il n'existe pas encore
  def cree_dossier_si_nexiste_pas
    dossier = File.dirname(@chemin)
    FileUtils.mkdir_p(dossier, :mode => 0777)
  end

end
