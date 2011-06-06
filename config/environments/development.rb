EVenti::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.delivery_method = :file
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Paperclip Stuff
  Paperclip.options[:swallow_stderr] = false
  Paperclip.options[:log_command] = false
  Paperclip.options[:command_path] = "DYLD_LIBRARY_PATH='/Users/Ryan/Developement/Libraries/ImageMagick-6.6.4/lib' /Users/Ryan/Developement/Libraries/ImageMagick-6.6.4/bin"

  Carmen.excluded_states = { 'US' => [ 'FM', 'GU', 'MH', 'MP', 'PR', 'VI', 'AE', 'PW', 'AA', 'AP'] }

  Recaptcha.configure do |config|
    # for prod use shell
    #export RECAPTCHA_PUBLIC_KEY  = '6Lc6BAAAAAAAAChqRbQZcn_yyyyyyyyyyyyyyyyy'
    #export RECAPTCHA_PRIVATE_KEY = '6Lc6BAAAAAAAAKN3DRm6VA_xxxxxxxxxxxxxxxxx'
    config.public_key  = '6Lf1AMUSAAAAAOdrl7HiOKwhOTzsLjOMvauUAPLn'
    config.private_key = '6Lf1AMUSAAAAAFz7h6NG-EtzztJqVZVKpnxhXHyl'
  end
end

