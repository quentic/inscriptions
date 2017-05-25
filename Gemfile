source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.18'
# pour récupérer les locales en français
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

gem 'slim-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Pour utiliser la pagination des listes à rallonge
gem 'will_paginate'

# Authentification des utilisateurs
gem "devise"
# Gestion des droits utilisateur
gem 'cancancan', '~> 1.10'

gem 'pdf-toolkit', '~> 1.1.0'

group :test do
  # Pour remplacer les fixtures dans les tests
  gem 'factory_girl_rails'

  #gem 'cucumber-rails'
  #gem "cucumber"

  # utiliser le pré-loader spring pour accélerer le lancement des tests
  gem 'spring'
end

# Ajoute l'environnement Pry complet pour déboguer et naviguer dans le code
group :development, :test do
  gem 'pry-rails'
  gem 'pry'
  gem 'pry-nav'
end
