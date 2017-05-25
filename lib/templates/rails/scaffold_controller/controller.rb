<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  # Contrôle d'accès via CanCan
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_action :set_<%= singular_table_name %>, only: [:index, :show, :edit, :update, :destroy]

  # GET <%= route_url %>
  def index
    filtre = params[:filtre]
    page = params[:page]

    if (filtre && !filtre.empty?)
      # Affiche les objets résultant d'un filtrage
      <%= plural_table_name %> = <%= singular_table_name.classify %>.rechercher(filtre)

    # listage d'un élément spécifié par son id
    elsif (@<%= singular_table_name %>)
      <%= plural_table_name %> = <%= singular_table_name.classify %>.where(id: @<%= singular_table_name %>.id)

    else
      <%= plural_table_name %> = <%= orm_class.all(class_name) %>

    end

    @<%= plural_table_name %> = <%= plural_table_name %>.page(page)
  end

  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to <%= table_name %>_path, notice: <%= "'#{human_name} ajouté.'" %>
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to <%= table_name %>_path, notice: <%= "'#{human_name} mis à jour.'" %>
    else
      render :edit
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: <%= "'#{human_name} supprimé.'" %>
  end

  # Filtre les données en fonction d'un terme recherché
  def rechercher
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>.rechercher(params[:terme])
    render partial: '<%= singular_table_name %>', collection: @<%= singular_table_name %>, layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %> unless params[:id].blank?
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end
end
<% end -%>
