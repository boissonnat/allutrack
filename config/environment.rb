# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Allutrack::Application.initialize!

# Issue's status constants
STATUS = ['open', 'closed']
