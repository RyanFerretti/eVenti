ActionMailer::Base.smtp_settings = {
  :address              => "mail.rockstaruproar.com",
  :port                 => 465,
  :domain               => "rockstaruproar.com",
  :user_name            => ENV['SMTP_USERNAME'],
  :password             => ENV['SMTP_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "missuproar.rockstaruproar.com"