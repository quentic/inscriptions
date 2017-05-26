<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < CrudController
  #custom_actions :resource => [:cloner]

  def attrs_for_index
    [<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>]
  end

  def attrs_for_form
    [<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>]
  end

  # GET <%= route_url %>
  def index
    if (@filtre && !@filtre.empty?)
      # Affiche les objets résultant d'un filtrage
      <%= plural_table_name %> = <%= singular_table_name.classify %>.filtre_par(@filtre)

    # listage d'un élément spécifié par son id
    elsif (@<%= singular_table_name %>)
      <%= plural_table_name %> = <%= singular_table_name.classify %>.where(id: @<%= singular_table_name %>.id)

    else
      <%= plural_table_name %> = <%= orm_class.all(class_name) %>

    end

    @<%= plural_table_name %> = <%= plural_table_name %>.page(@page)
  end

  # POST <%= route_url %>
  def create
    super(notice: <%= "'#{human_name} ajouté.'" %>)
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    super(notice: <%= "'#{human_name} mis à jour.'" %>)
  end

  # DELETE <%= route_url %>/1
  def destroy
    super(notice: <%= "'#{human_name} supprimé.'" %>)
  end

  # Filtre les opérations du stock en fonction d'un terme recherché
  # - On limite à 100 résultats
  def rechercher
    @<%= plural_table_name %> = <%= orm_class %>.filtre_par(@filtre).limit(100)
    render @<%= plural_table_name %>
  end

private
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
