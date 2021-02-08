source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'

# Use mysql as the database for Active Record
gem 'mysql2'

# pour récupérer les locales en français
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x

gem 'slim-rails'
# Pour des controlleurs simplifiés
gem 'inherited_resources'
# Pour des formulaires par défaut super simples
gem 'simple_form'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 5.0'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # See https://github.com/rails/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.2'
end

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# utiliser Puma comme serveur d'application
gem 'puma', '~> 3.7'

# Pour utiliser la pagination des listes à rallonge
gem 'will_paginate'

# Authentification des utilisateurs
gem 'devise'
# Gestion des droits utilisateur
gem 'cancancan', '~> 1.10'

gem 'pdf-toolkit', '~> 1.1.0'

# Gère le téléversement de fichiers
gem 'carrierwave', '~> 1.3'

# Pour la génération de rapports au format Office Open XML (xlsx, LibreOffice)
gem 'rubyzip', '~> 1.1.0'
gem 'axlsx', '2.1.0.pre'
gem 'axlsx_rails'
gem 'acts_as_xlsx'

# La bibliothèque graphique RMagick
gem 'rmagick'

# Ajoute l'environnement Byebug pour déboguer et naviguer dans le code
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  #gem 'capybara', '~> 2.13'
  #gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Pour remplacer les fixtures dans les tests
  gem 'factory_bot_rails'
end
