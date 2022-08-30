require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module App
  class Application < Rails::Application
    
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    # Added middleware manually.
    # apiモードでサインイン、ログイン、ログアウトをするために必要なもの
    # 公式ではCookieStore推奨である
    # https://daido.hatenablog.jp/entry/2020/05/06/143145
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CacheStore
    #config.middleware.use ActionDispatch::Session::CookieStore
    #config.middleware.use ActionDispatch::ContentSecurityPolicy::Middleware
  end
end
