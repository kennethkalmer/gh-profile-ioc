require File.expand_path('app/profile')

require 'web'
require 'sprockets'
require 'handlebars_assets'
require 'coffee_script'

require 'haml'
require File.expand_path('vendor/haml_sprockets_engine')
Sprockets.register_engine '.haml', HamlAssets::HamlSprocketsEngine

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path File.expand_path('../assets/javascripts', __FILE__)
  environment.append_path File.expand_path('../assets/stylesheets', __FILE__)
  environment.append_path HandlebarsAssets.path
  environment.logger.level = Logger::DEBUG
  run environment
end

map '/' do
  run Profile::Web
end
