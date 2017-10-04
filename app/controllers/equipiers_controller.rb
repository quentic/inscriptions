class EquipiersController < CrudController
  #custom_actions :resource => [:cloner]

  def attrs_for_index
    [:nom, :prenom, :telephone_fixe, :telephone_portable, :email]
  end

  def attrs_for_form	
[:nom, :prenom, :rue, :cp, :ville, :telephone_fixe, :telephone_portable, :email, :profession, :date_naissance, :lieu_naissance, :nationalite, :permis_conduire_num, :permis_conduire, :passeport_num, :passeport, :passeport_date_delivrance, :passeport_lieu_delivrance, :passeport_date_validite, :groupe_sanguin, :nom_prenom_a_prevenir, :tel_a_prevenir, :equipage_id]
  end

  before_action :set_equipier, only: [:update]
  before_action :set_equipage, only: [:index, :new, :create, :edit, :update, :destroy]

  # GET /equipiers
  def index
    if (@filtre && !@filtre.empty?)
      # Affiche les objets résultant d'un filtrage
      equipiers = Equipier.filtre_par(@filtre)

    # listage d'un élément spécifié par son id
    elsif (@equipage)
      equipiers = @equipage.equipiers

    # listage d'un élément spécifié par son id
    elsif (@equipier)
      equipiers = Equipier.where(id: @equipier.id)

    else
      equipiers = Equipier.all

    end

    @equipiers = equipiers.page(@page)
  end

  # GET /equipier
  def new
    @equipier = @equipage.equipiers.new
    super
  end

  # POST /equipiers
  def create
    @equipier = @equipage.equipiers.new(equipier_params)
    @equipier.user = current_user

    super(notice: 'Equipier ajouté.') {
      equipage_equipiers_path(@equipage)
    }
  end

  # PATCH/PUT /equipage/x/equipiers/1
  def update
    super {
      equipage_equipiers_path(@equipage)
    }
  end

  # DELETE /equipage/x/equipiers/1
  def destroy
    super {
      equipage_equipiers_path(@equipage)
    }
  end

private
  # Only allow a trusted parameter "white list" through.
  def equipier_params
    params.require(:equipier).permit(:conducteur, :nom, :prenom, :photo,
	:rue, :cp, :ville, 
	:telephone_fixe, :telephone_portable, :email, 
	:profession, 
	:date_naissance, :lieu_naissance, :nationalite, 
	:permis_conduire_num, :permis_conduire, 
	:passeport_num, :passeport, :passeport_date_delivrance, :passeport_lieu_delivrance, :passeport_date_validite, 
	:groupe_sanguin, 
        :taille_t_shirt,
	:nom_prenom_a_prevenir, :tel_a_prevenir, 
	:equipage_id, 
	:user_id)
  end

  def set_equipier
    @equipier = Equipier.find(params[:id])
  end

  def set_equipage
    @equipage = Equipage.find(params[:equipage_id]) unless params[:equipage_id].blank?
    unless @equipage
      @equipage = Equipage.find(params[:equipier][:equipage_id]) unless params[:equipier][:equipage_id].blank?
    end
  end

end
