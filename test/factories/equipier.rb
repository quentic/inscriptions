FactoryGirl.define do

  factory :equipier,  class: Equipier do

    factory :equipier_1 do
      user_id 1
      association :equipage, factory: :equipage_1
      nom 'Quentin'
      prenom 'Christian'
    end

  end

end
