require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Inscriptions
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << "#{Rails.root}/lib"
    config.autoload_paths += Dir[Rails.root.join('app', 'controllers', '**', '*.rb')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '**', '*.rb')]

    # Dossier et sous-dossiers pour les fichiers de langue
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Paris'

    # Pour un controleur donné, on n'inclut que application_helper et le helper spécifique à ce controleur
    config.action_controller.include_all_helpers = false

    # Configurer le générateur
    config.generators do |g|
      g.stylesheets false

      # Pas de fixture SVP, on utilise FactoryGirl
      g.test_framework  :test_unit, fixture: false
    end

  end
end
