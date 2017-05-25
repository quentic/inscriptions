FactoryGirl.define do

  factory :user do
    prenom 'Linus'
    nom 'Torvals'
    password 'password'

    factory :administrateur do
      email 'administrateur@xerox.com'
      admin true
    end

    factory :inscription_manager do
      email 'inscription_manager@gmail.com'
      campagne_manager true
    end

  end

end
