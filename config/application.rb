require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RongyiTermCms
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'zh-CN'

    config.autoload_paths += %W(#{config.root}/lib #{config.root}/app/models/ckeditor)

    config.assets.enabled = true
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w(ckeditor/*)
    config.to_prepare do
      Devise::SessionsController.layout "application_devise"
      Devise::RegistrationsController.layout "application_devise"
      Devise::ConfirmationsController.layout "application_devise"
      Devise::UnlocksController.layout "application_devise"            
      Devise::PasswordsController.layout "application_devise"        
    end
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    config.action_mailer.raise_delivery_errors = true     #注意，在development.rb下需修改成true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.sina.com",  #smtp.qq.com
      port:  25,
      domain: "sina.com",   #qq.com
      authentication: :login,
      user_name: "xxxxxxx@sina.com", #修改邮箱
      password: "xxxxxxxx" #修改正确的密码
    }   
  end
end
