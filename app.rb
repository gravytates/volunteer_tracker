require 'sinatra'
require 'sinatra/reloader'
require './lib/project.rb'
require './lib/volunteer.rb'
require 'pry'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end
