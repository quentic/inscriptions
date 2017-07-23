class EquipagesController < CrudController
  #custom_actions :resource => [:cloner]

  def attrs_for_index
    [:numero, :type_puissance, :immatriculation]
  end

  def attrs_for_form
[:numero, :type_puissance, :carte_grise_titulaire, :carte_grise_date_emission, :premiere_mise_en_circ, :immatriculation, :cie_assurance]
  end

  before_action :set_equipage, only: [:index]

  # GET /equipages
  def index
    if (@filtre && !@filtre.empty?)
      # Affiche les objets résultant d'un filtrage
      equipages = Equipage.filtre_par(@filtre)

    # listage d'un élément spécifié par son id
    elsif (@equipage)
      equipages = Equipage.where(id: @equipage.id)

    else
      equipages = Equipage.all.order(:numero)

    end
    
    respond_to do |format|
      format.html { 
        @equipages = equipages.page(@page)
      }
      format.xlsx
    end
  end

  # POST /equipages
  def create
    @equipage = Equipage.new(equipage_params)
    @equipage.user = current_user

    super(notice: 'Equipage ajouté.')
  end

private
  # Only allow a trusted parameter "white list" through.
  def equipage_params
    params.require(:equipage).permit(:numero, :type_puissance, 
	:carte_grise_titulaire, :carte_grise_date_emission, :premiere_mise_en_circ, :immatriculation, 
	:cie_assurance,
	:user_id)
  end

  def set_equipage
    @equipage = Equipage.find(params[:id]) unless params[:id].blank?
  end

end
