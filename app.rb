require 'sinatra'
require 'sinatra/reloader'
require './lib/project.rb'
require './lib/volunteer.rb'
require 'pg'
require 'pry'

also_reload('lib/**/*.rb')
DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/projects/new') do
  name = params.fetch('name')
  id = nil
  @project = Project.new(:name => name, :id => nil)
  @project.save
  @projects = Project.all
  erb(:index)
end

get('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i)
  erb(:project)
end

patch('/projects/:id/edit') do
  project = Project.find(params.fetch("id").to_i)
  name = params.fetch('name')
  project.update({:name => name})
  @projects = Project.all
  erb(:index)
end

delete('/projects/:id/delete') do
  project = Project.find(params.fetch("id").to_i)
  project.delete
  @projects = Project.all
  erb(:index)
end
