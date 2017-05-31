require 'test_helper'

class EquipagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @equipage = create(:equipage_1)
  end

  test "should get index" do
    get equipages_url
    assert_response :success
  end

  test "should get new" do
    get new_equipage_url
    assert_response :success
  end

  test "should create equipage" do
    assert_difference('Equipage.count') do
      post equipages_url, params: { equipage: { carte_grise_date_emission: @equipage.carte_grise_date_emission, carte_grise_titulaire: @equipage.carte_grise_titulaire, cie_assurance: @equipage.cie_assurance, immatriculation: @equipage.immatriculation, premiere_mise_en_circ: @equipage.premiere_mise_en_circ, type_puissance: @equipage.type_puissance } }
    end

    assert_redirected_to equipage_url(Equipage.last)
  end

  test "should show equipage" do
    get equipage_url(@equipage)
    assert_response :success
  end

  test "should get edit" do
    get edit_equipage_url(@equipage)
    assert_response :success
  end

  test "should update equipage" do
    patch equipage_url(@equipage), params: { equipage: { carte_grise_date_emission: @equipage.carte_grise_date_emission, carte_grise_titulaire: @equipage.carte_grise_titulaire, cie_assurance: @equipage.cie_assurance, immatriculation: @equipage.immatriculation, premiere_mise_en_circ: @equipage.premiere_mise_en_circ, type_puissance: @equipage.type_puissance } }
    assert_redirected_to equipage_url(@equipage)
  end

  test "should destroy equipage" do
    assert_difference('Equipage.count', -1) do
      delete equipage_url(@equipage)
    end

    assert_redirected_to equipages_url
  end
end
