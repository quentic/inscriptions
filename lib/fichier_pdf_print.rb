# Des méthodes pour travailler sur les pdf de Offres Print
class FichierPdfPrint

  attr_reader :reference
  attr_reader :bat_reference
  attr_reader :ref_fichier, :ref_pdf
  attr_reader :chemin

  # Constructeur de la classe FichierPdfGe
  #
  # Paramètres :
  # - reference : nom du fichier PDF (sans extension)
  # - prefixe : prefixe à ajouter en tête du nom de fichier (optionnel)
  # - dossier (optionnel): identifiant de l'élément de campagne (utilisé pour créer le sous-dossier de rangement dans le référentiel)
  # - hote (optionnel) : hote de l'URL d'appel (permet de construire les URL en fonction du réseau de l'utilisateur)
  def initialize(reference, prefixe="", dossier="", hote="")
    @fichier = FichierPdf.new(reference, prefixe, hote)

    @dossier = dossier
    @ref_fichier = @fichier.ref_fichier
    @fichier.chemin = path_to_file("print_pdf_path") # nécessaire pour appeler recup_nbpages
    @chemin = @fichier.chemin

    @hote = hote
  end

  # Fournit le chemin d'accès à un fichier en fonction du type de fichier fourni en paramètre
  def path_to_file(type_acces)
    case type_acces
    when "print_pdf_path"
      "public/upload/#{@dossier}/#{@ref_fichier}.pdf"
    when "print_pdf_http"
      "http://#{@hote}:3000/upload/#{@dossier}/#{@ref_fichier}.pdf"
    end
  end

  # Fournit le chemin d'accès au pdf
  def chemin_du_fichier
    self.path_to_file("print_pdf_path")
  end

  def recup_nbpages
    @fichier.recup_nbpages
  end

  # Detruit le fichier et le dossier correspondant s'il est vide
  def detruit_fichier_et_dossier_si_vide
    @fichier.detruit_fichier_et_dossier_si_vide
  end

  # Vérifie si un PDF est déjà dans :
  # - public/upload (pour ne pas l'écraser par une nouvelle publication)
  def est_deja_archive?
    ref_dans_upload_min =  self.change_extension(self.path_to_file("print_pdf_path"), "pdf")
    ref_dans_upload_maj =  self.change_extension(ref_dans_upload_min, "PDF")

    return File.exists?(ref_dans_upload_min) || File.exists?(ref_dans_upload_maj)
    end

  # Publie un document dans public/upload en créant au besoin un dossier basé sur la référence du document
  def publier_dans_referentiel(contenu_fichier)
    ref_fichier_dans_referentiel = @fichier.chemin
    Fichier.new(ref_fichier_dans_referentiel).cree_dossier_si_nexiste_pas

    File.open(ref_fichier_dans_referentiel, "wb", 0744) { |f|
      f.write(contenu_fichier.read)
    }
  end

  # Supprime un document de public/upload et supprime le dossier s'il est vide après suppression du document
  def supprimer
    @fichier.supprimer
  end

end
