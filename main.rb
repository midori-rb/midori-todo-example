require 'bundler'
Bundler.require
require 'json'
require 'yaml'

env = ENV['MIDORI_ENV'] ? ENV['MIDORI_ENV'] : 'development'

Dir[File.dirname(__FILE__) + '/routes/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/services/*.rb'].each { |file| require file }

Midori::Configure.before = proc do
  DB = Sequel.connect(YAML.load_file('config/db.yml')[env])
  Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |file| require file }
end

class Route < Midori::API
  env = ENV['MIDORI_ENV'] ? ENV['MIDORI_ENV'] : 'development'
  mount '/user', UserRoute
  mount '/task', TaskRoute
  mount('', AppRoute) if env == 'development' # Static file for development
  mount '_', ErrorRoute
end

Midori::Runner.new(Route).start
