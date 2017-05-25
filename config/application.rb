require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DscmPrint
  class Application < Rails::Application
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

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Pour un controleur donné, on n'inclut que application_helper et le helper spécifique à ce controleur
    config.action_controller.include_all_helpers = false

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    I18n.available_locales = :fr
    # Pour faire taire le message d'avertissement apparu depuis Rails 4
    I18n.enforce_available_locales = false

    # Configurer le générateur
    config.generators do |g|
      g.stylesheets false

      # Pas de fixture SVP, on utilise FactoryGirl
      g.test_framework  :test_unit, fixture: false
    end

  end
end

