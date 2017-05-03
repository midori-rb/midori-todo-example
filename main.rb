require 'bundler'
Bundler.require
require 'json'
require 'yaml'

env = ENV['RACK_ENV'] ? ENV['RACK_ENV'] : 'development'

Dir[File.dirname(__FILE__) + '/route/*.rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/service/*.rb'].each { |file| require file }

Midori::Configure.before = proc do
  DB = Sequel.connect(YAML.load_file('config/db.yml')[env])
  Dir[File.dirname(__FILE__) + '/model/*.rb'].each { |file| require file }
end

class Route < Midori::API
  mount '/user', UserRoute
  mount '/task', TaskRoute
  mount '', AppRoute
  mount '_', ErrorRoute
end

Midori::Runner.new(Route).start
