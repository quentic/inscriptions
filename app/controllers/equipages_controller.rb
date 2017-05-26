class EquipagesController < CrudController
  #custom_actions :resource => [:cloner]

  def attrs_for_index
    [:type_puissance, :carte_grise_titulaire, :carte_grise_date_emission, :premiere_mise_en_circ, :immatriculation, :cie_assurance]
  end

  def attrs_for_form
    [:type_puissance, :carte_grise_titulaire, :carte_grise_date_emission, :premiere_mise_en_circ, :immatriculation, :cie_assurance]
  end

  # GET /equipages
  def index
    if (@filtre && !@filtre.empty?)
      # Affiche les objets résultant d'un filtrage
      equipages = Equipage.filtre_par(@filtre)

    # listage d'un élément spécifié par son id
    elsif (@equipage)
      equipages = Equipage.where(id: @equipage.id)

    else
      equipages = Equipage.all

    end

    @equipages = equipages.page(@page)
  end

  # POST /equipages
  def create
    super(notice: 'Equipage ajouté.')
  end

  # PATCH/PUT /equipages/1
  def update
    super(notice: 'Equipage mis à jour.')
  end

  # DELETE /equipages/1
  def destroy
    super(notice: 'Equipage supprimé.')
  end

  # Filtre les opérations du stock en fonction d'un terme recherché
  # - On limite à 100 résultats
  def rechercher
    @equipages = Equipage.filtre_par(@filtre).limit(100)
    render @equipages
  end

private
  # Only allow a trusted parameter "white list" through.
  def equipage_params
    params.require(:equipage).permit(:type_puissance, :carte_grise_titulaire, :carte_grise_date_emission, :premiere_mise_en_circ, :immatriculation, :cie_assurance)
  end
end
