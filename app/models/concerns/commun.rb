# Les méthodes communes à toutes les classes
module Commun
  extend ActiveSupport::Concern

  module ClassMethods

    # Renvoie une chaîne SQL pour une recherche full text
    def full_text(terme)
      terme.blank? ? "%" : "%#{terme.strip}%"
    end

    # nombre d'éléments affichés par page de liste
    def per_page
      10
    end

    def par_libelle
      order(libelle: :asc)
    end

    def par_nom
      order(nom: :asc)
    end

  end

end
