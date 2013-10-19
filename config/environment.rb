# Load the Rails application.
require File.expand_path('../application', __FILE__)

Mime::Type.register "image/jpg", :jpg

# Initialize the Rails application.
Barcodr::Application.initialize!
