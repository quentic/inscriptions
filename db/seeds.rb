# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

admin = User.create(:prenom => 'Christian', :nom => 'Quentin',
       :email => 'christian.quentin@xgssas.com', :password => 'Pass123.',
       :password_confirmation => 'Pass123.'
       )

if admin.errors.blank?
    puts "***Utilisateur #{admin.prenom} #{admin.nom} créé ***"
    admin.admin = true
    admin.save!
    puts "***admin role assigned to #{admin.prenom} #{admin.nom}***"
else
    puts "admin user failed to create due to below reasons:"
    admin.errors.each do |x, y|
       puts"#{x} #{y}" # x will be the field name and y will be the error on it
     end
end

utilisateur = User.create(:prenom => 'Aline', :nom => 'Goupil',
       :email => 'aline.goupil@hotmail.fr', :password => 'Pass123.',
       :password_confirmation => 'Pass123.'
       )
if utilisateur.errors.blank?
    puts "***Utilisateur #{utilisateur.prenom} #{utilisateur.nom} créé ***"
    utilisateur.inscriptions_manager = true
    utilisateur.save!
    puts "***#{utilisateur.prenom} #{utilisateur.nom} est maintenant inscription_manager ***"
end


