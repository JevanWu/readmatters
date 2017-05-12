require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsFoundation
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Beijing'#'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:zh, :en]
    config.i18n.default_locale = :zh
    config.generators.assets = false
    config.generators.helper = false

    # Redis config
    config.cache_store = :redis_store, {
      host: "localhost",
      port: 6379,
      db: 0,
      namespace: "cache",

      expires_in: 24.hours,
      compress: true,
      #compress_threshold: 32.kilobytes,
    }
  end
end
