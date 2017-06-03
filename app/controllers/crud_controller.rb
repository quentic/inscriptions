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

  def update(options={})
    update! do |succes, echec|
      succes.html do
        flash[:notice] = "#{t(resource_class.to_s.downcase)}_maj"
	if block_given?
	  redirect_to yield
        else        
          redirect_to collection_url(page: @page)
        end
      end

      echec.html do
        render action: 'edit'
      end
    end
  end

  def destroy(options={})
    destroy! do |succes, echec|
      succes.html do
        flash[:notice] = "#{t(resource_class.to_s.downcase)}_supprime"
	if block_given?
	  redirect_to yield
        else        
          redirect_to collection_url(page: @page)
        end
      end

      echec.html do
        flash[:error] = "Impossible de supprimer ce(tte) #{t(resource_class.to_s)}"
        flash[:error] << '<br />' + resource.errors[:base][0]
        redirect_to collection_url(page: @page)
      end

    end

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
