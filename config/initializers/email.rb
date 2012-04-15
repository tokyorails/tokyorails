ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => ENV['SMTP_USERNAME'],
  :password             => ENV['SMTP_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = Rails.application.config.default_url
