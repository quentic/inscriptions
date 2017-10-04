class EquipagesController < CrudController
  include RenderCsv

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

    super(notice: t(:equipage_cree))
  end

  # GET /equipages/recap
  def recap

    respond_to do |format|
      format.html {
        @equipages = Equipage.avec_equipiers
        # recap.html.slim
      }
      format.csv { 
        @equipages = Equipage.avec_equipiers_csv
        render plain: to_csv(
          @equipages.all,
          [
            :numero,
            :prenom,
            :nom,
            :rue,
            :cp,
            :ville,
            :telephone_fixe,
            :telephone_portable,
            :email,
            :profession,
            :date_naissance,
            :lieu_naissance,
            :nationalite,
            :permis_conduire_num,
            :passeport_num,
            :passeport_date_delivrance,
            :passeport_lieu_delivrance,
            :passeport_date_validite,
            :groupe_sanguin,
            :nom_prenom_a_prevenir,
            :tel_a_prevenir,
            :taille_t_shirt
          ]
        )
      }
     end
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
