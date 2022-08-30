require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FormsClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Add environment file for development
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)
  end

  # Add hosts here
  # config.hosts << "cef5-175-176-7-128.ap.ngrok.io"
  config.hosts << "forms_clone.localhost.com"

  # Auto delete tmp files
  config.middleware.use Rack::TempfileReaper
  end
end
