require_relative 'boot'

require 'rails/all'

require 'barby'
require 'barby/barcode/code_128'
require 'chunky_png'
require 'barby/outputter/png_outputter'
require 'barby/outputter/html_outputter'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Labbesne
  class Application < Rails::Application
    # to debug rails server hangs
    config.middleware.insert_before Rack::Sendfile, ActionDispatch::DebugLocks
    # Load application's model / class decorators
    initializer 'spree.decorators' do |app|
      config.to_prepare do
        Dir.glob(Rails.root.join('app/**/*_decorator*.rb')) do |path|
          require_dependency(path)
        end
      end
    end
    config.before_initialize do
      Dir.glob(File.join(File.dirname(__FILE__), "../lib/spree/permission_sets/*.rb")) do |c|
        require_dependency(c)
      end
    end
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.configure do |env|
      env.export_concurrent = false
    end
  end
end
