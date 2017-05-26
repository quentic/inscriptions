class EquipiersController < CrudController
  #custom_actions :resource => [:cloner]

  def attrs_for_index
    [:nom, :prenom, :rue, :cp, :ville, :telephone_fixe, :telephone_portable, :email, :profession, :date_naissance, :date, :lieu_naissance, :nationalite, :num_permis_conduire, :passeport_num, :passeport_date_delivrance, :passeport_lieu_delivrance, :passeport_date_validite, :groupe_sanguin, :nom_prenom_a_prevenir, :tel_a_prevenir, :equipage_id]
  end

  def attrs_for_form
    [:nom, :prenom, :rue, :cp, :ville, :telephone_fixe, :telephone_portable, :email, :profession, :date_naissance, :date, :lieu_naissance, :nationalite, :num_permis_conduire, :passeport_num, :passeport_date_delivrance, :passeport_lieu_delivrance, :passeport_date_validite, :groupe_sanguin, :nom_prenom_a_prevenir, :tel_a_prevenir, :equipage_id]
  end

  # GET /equipiers
  def index
    if (@filtre && !@filtre.empty?)
      # Affiche les objets résultant d'un filtrage
      equipiers = Equipier.filtre_par(@filtre)

    # listage d'un élément spécifié par son id
    elsif (@equipier)
      equipiers = Equipier.where(id: @equipier.id)

    else
      equipiers = Equipier.all

    end

    @equipiers = equipiers.page(@page)
  end

  # POST /equipiers
  def create
    super(notice: 'Equipier ajouté.')
  end

  # PATCH/PUT /equipiers/1
  def update
    super(notice: 'Equipier mis à jour.')
  end

  # DELETE /equipiers/1
  def destroy
    super(notice: 'Equipier supprimé.')
  end

  # Filtre les opérations du stock en fonction d'un terme recherché
  # - On limite à 100 résultats
  def rechercher
    @equipiers = Equipier.filtre_par(@filtre).limit(100)
    render @equipiers
  end

private
  # Only allow a trusted parameter "white list" through.
  def equipier_params
    params.require(:equipier).permit(:nom, :prenom, :rue, :cp, :ville, :telephone_fixe, :telephone_portable, :email, :profession, :date_naissance, :date, :lieu_naissance, :nationalite, :num_permis_conduire, :passeport_num, :passeport_date_delivrance, :passeport_lieu_delivrance, :passeport_date_validite, :groupe_sanguin, :nom_prenom_a_prevenir, :tel_a_prevenir, :equipage_id)
  end
end
