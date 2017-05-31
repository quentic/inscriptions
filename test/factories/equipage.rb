FactoryGirl.define do

  factory :equipage,  class: Equipage do

    factory :equipage_1 do
      association :user, factory: :inscription_manager
      numero 1
      type_puissance "2CV"
      carte_grise_titulaire "Christian Quentin"
    end

  end

end
