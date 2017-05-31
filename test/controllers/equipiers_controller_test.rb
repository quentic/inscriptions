require 'test_helper'

class EquipiersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipier = create(:equipier_1)
  end

  test "should get index" do
    get equipiers_url
    assert_response :success
  end

  test "should get new" do
    get new_equipier_url
    assert_response :success
  end

  test "should create equipier" do
    assert_difference('Equipier.count') do
      post equipiers_url, params: { equipier: { cp: @equipier.cp, date_naissance: @equipier.date_naissance, email: @equipier.email, equipage_id: @equipier.equipage_id, groupe_sanguin: @equipier.groupe_sanguin, lieu_naissance: @equipier.lieu_naissance, nationalite: @equipier.nationalite, nom: @equipier.nom, nom_prenom_a_prevenir: @equipier.nom_prenom_a_prevenir, num_permis_conduire: @equipier.num_permis_conduire, passeport_date_delivrance: @equipier.passeport_date_delivrance, passeport_date_validite: @equipier.passeport_date_validite, passeport_lieu_delivrance: @equipier.passeport_lieu_delivrance, passeport_num: @equipier.passeport_num, prenom: @equipier.prenom, profession: @equipier.profession, rue: @equipier.rue, tel_a_prevenir: @equipier.tel_a_prevenir, telephone_fixe: @equipier.telephone_fixe, telephone_portable: @equipier.telephone_portable, ville: @equipier.ville } }
    end

    assert_redirected_to equipier_url(Equipier.last)
  end

  test "should show equipier" do
    get equipier_url(@equipier)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipier_url(@equipier)
    assert_response :success
  end

  test "should update equipier" do
    patch equipier_url(@equipier), params: { equipier: { cp: @equipier.cp, date_naissance: @equipier.date_naissance, email: @equipier.email, equipage_id: @equipier.equipage_id, groupe_sanguin: @equipier.groupe_sanguin, lieu_naissance: @equipier.lieu_naissance, nationalite: @equipier.nationalite, nom: @equipier.nom, nom_prenom_a_prevenir: @equipier.nom_prenom_a_prevenir, num_permis_conduire: @equipier.num_permis_conduire, passeport_date_delivrance: @equipier.passeport_date_delivrance, passeport_date_validite: @equipier.passeport_date_validite, passeport_lieu_delivrance: @equipier.passeport_lieu_delivrance, passeport_num: @equipier.passeport_num, prenom: @equipier.prenom, profession: @equipier.profession, rue: @equipier.rue, tel_a_prevenir: @equipier.tel_a_prevenir, telephone_fixe: @equipier.telephone_fixe, telephone_portable: @equipier.telephone_portable, ville: @equipier.ville } }
    assert_redirected_to equipier_url(@equipier)
  end

  test "should destroy equipier" do
    assert_difference('Equipier.count', -1) do
      delete equipier_url(@equipier)
    end

    assert_redirected_to equipiers_url
  end
end
