class CrudController < InheritedResources::Base
  # Contrôle d'accès via CanCan
  authorize_resource :class => resource_class
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  custom_actions :collection => :rechercher

  def attrs_for_index
    []
  end

  def attrs_for_form
    []
  end

  helper_method :attrs_for_index
  helper_method :attrs_for_form

  # Filtre les objets en fonction d'un terme recherché
  def rechercher
    set_collection_ivar(resource_class.filtre_par(@filtre).limit(100))
    render collection
  end

  # Appelle la méthode update! de InheritedResources et reroute avec la page d'origine en paramètre (et le filtre)
  def update(options={})
    page   = @page.blank?   ? '' : "?page=#{@page}"
    filtre = @filtre.blank? ? '' : "&filtre=#{@filtre}"

    update!(options) { collection_url + "#{page}#{filtre}" }
  end

  # Appelle la méthode destroy! de InheritedResources et reroute avec la page d'origine en paramètre (et le filtre)
  def destroy(options={})
    page   = @page.blank?   ? '' : "?page=#{@page}"
    filtre = @filtre.blank? ? '' : "&filtre=#{@filtre}"

    destroy!(options) { collection_url + "#{page}#{filtre}" }
  end

 private

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.page(@page))
  end

  # Rédéfinit cette méthode pour une redirection vers la page index après :
  # - show
  # - création
  # - modification
  # - suppression
  def smart_resource_url
    url = nil
    if respond_to? :show
      url = smart_collection_url rescue nil
    end
    if respond_to? :create
      url = smart_collection_url rescue nil
    end
    if respond_to? :update
      url = smart_collection_url rescue nil
    end
    url ||= smart_collection_url
  end

#  # Pour préfixer les créations avec l'utilisateur courant
#  def begin_of_association_chain
#    @current_user
#  end

end