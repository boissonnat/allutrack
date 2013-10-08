# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Allutrack::Application.initialize!

# Issue's status constants
STATUS = ['open', 'closed']

# Config mailer through sendgrid
ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com',
    :enable_starttls_auto => true
}

