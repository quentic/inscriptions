# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  PROFILS = %w(campagne_manager)

  # Vérifie si l'utilisateur est un administrateur authentifié
  def admin_logged_in?
    user_signed_in? && (current_user.admin?)
  end

  # Définit les méthodes pour vérifier si l'utilisateur a bien le profil attendu pour accéder aux données
  PROFILS.each do |profil|
    define_method "#{profil}_logged_in?" do
      if current_user
        profil_utilisateur = current_user.method("#{profil}?")
        user_signed_in? && (profil_utilisateur.call || current_user.admin?)
      else
        false
      end
    end
  end

  # Affiche la valeur (éventuellement non définie) d'un champ datetime
  def affiche_date_heure(date_heure)
    date_heure ? date_heure.strftime("%Y/%m/%d %H:%M") : ""
  end

  # Affiche la date (éventuellement non définie) d'un champ datetime
  def affiche_date(date_heure)
    date_heure ? date_heure.strftime("%d/%m/%Y") : ""
  end

  # Affiche un formulaire pour filtrer les données affichées dans une liste d'articles, de commandes, etc.
  def filtrer(url, titre_filtre, champ_de_recherche, consigne)
    titre_filtre = raw titre_filtre

    form_tag(url, method: :get, class: :rech) {

      content_tag :div do

        content_tag(:label, titre_filtre) +

        search_field_tag(champ_de_recherche, nil, class: 'terme_recherche focus_defaut', placeholder: consigne) +

        submit_tag('OK', class: :en_ligne)

       end
     }
  end

  # Construit une url dépendant du serveur
  def link_to_server(texte_lien, chemin_sur_serveur, classe, titre="")
    <<LINKSTRING
      <script type="text/javascript">
          document.write("<a href='http://" + window.location.hostname + "#{chemin_sur_serveur}' class='#{classe}' target='_new' title='#{titre}'>#{texte_lien}</a>");
      </script>
LINKSTRING
  end

  # Construit une url vers l'aide en ligne
  def aide_via_wiki(nom_page, ancre = "", texte_lien = "Aide")
    raw link_to_server texte_lien, "/wikioffresprint/index.php/Aide_#{nom_page}#{ancre.blank? ? '' : '#' + ancre}", :help
  end

  # Construit une url vers Redmine pour signaler un bug sur l'application Offres Print
  def signaler_un_bug
    raw link_to 'Signaler un bug / une amélioration', "http://#{request.host}:3333/projects/maaf-dscm/issues/new", target: :blank, class: :bugs
  end

  # Affiche le créateur de la référence
  def info_reference_creee_par(user, creee_le, mise_a_jour_le)
    title = "Référence créée"
    title += " par #{user.prenom}" if user
    title += ", le " + creee_le.strftime('%d/%m/%Y à %H:%M') unless creee_le.blank?
    title += ", mise à jour le " + mise_a_jour_le.strftime('%d/%m/%Y à %H:%M') unless mise_a_jour_le.blank? || (creee_le == mise_a_jour_le)
    {title: title}
  end

  # Affiche l'auteur de la commande
  def info_commande_creee_par(user, creee_le)
    title = "Commande créée"
    title += " par #{user.prenom}" if user
    title += ", le " + creee_le.strftime('%d/%m/%Y à %H:%M') unless creee_le.blank?
    {title: title}
  end

  # Gère l'affichage des erreurs
  def afficher_erreurs(objet, message_erreur="")
    if message_erreur.blank?
      message = I18n.t :header, scope: [:activerecord, :errors, :template], model: objet.model_name, count: objet.errors.count
    else
      message = I18n.t :header_specifique, scope: [:activerecord, :errors, :template], model: objet.model_name.human, message_erreur: message_erreur, count: objet.errors.count
    end

    if objet.errors.any?
      err = <<HTML
        <div id="error_explanation">
          <h2>#{message}</h2>
          <ul>
HTML

          objet.errors.full_messages.each do |msg|
            err += "<li>#{msg}</li>"
          end

          err += "</ul>"
          err += "</div>"
          raw err
    end
  end

  # Pluralise le texte des unités
  def pluriel(quantite, unite_de_facturation)
    return number_with_delimiter(quantite) if unite_de_facturation.blank?

    if quantite < 2
      unite = unite_de_facturation[/[\wîïéèà]*/]
    else
      unite = unite_de_facturation[/[\wîïéèà]*/].pluralize(:fr) + unite_de_facturation[/ .*/].to_s
    end
    number_with_delimiter(quantite) + " " + unite
  end

  # Affiche le créateur de l'élément de campagne
  def info_element_cree_par(user, cree_le, mise_a_jour_le)
    title = "Element créé"
    title += " par #{user.prenom}" if user
    title += ", le " + cree_le.strftime('%d/%m/%Y à %H:%M') unless cree_le.blank?
    title += ", mise à jour le " + mise_a_jour_le.strftime('%d/%m/%Y à %H:%M') unless mise_a_jour_le.blank? || (cree_le == mise_a_jour_le)
    {title: title}
  end

  def classe_etat(etat_dossier)
    case etat_dossier
    when 'annule'
      {class: 'annule'}
    when 'engage'
      {class: 'engage'}
    when 'livre'
      {class: 'livre'}
    when 'previsionnel'
      {class: 'previsionnel'}
    else
      {}
    end
  end

end