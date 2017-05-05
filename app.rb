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
  @volunteers = Volunteer.all
  erb(:index)
end

post('/projects/new') do
  name = params.fetch('name')
  id = nil
  @project = Project.new(:name => name, :id => nil)
  @project.save
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end

get('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i)
  @volunteers = Volunteer.all
  erb(:project)
end

patch('/projects/:id/edit') do
  project = Project.find(params.fetch("id").to_i)
  name = params.fetch('name')
  project.update({:name => name})
  @project = Project.find(params.fetch('id').to_i)
  @volunteers = Volunteer.all
  erb(:project)
end

delete('/projects/:id/delete') do
  project = Project.find(params.fetch("id").to_i)
  project.delete
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end

post('/volunteers/new') do
  name = params.fetch('name')
  id = nil
  project_id = params.fetch("project_id").to_i
  @volunteer = Volunteer.new(:name => name, :id => id, :project_id => project_id)
  @project = Project.find(project_id)
  @volunteer.save
  @volunteers = Volunteer.all
  erb(:project)
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  project_id = @volunteer.project_id
  @project = Project.find(project_id)
  erb(:volunteer)
end

patch('/volunteers/:id/edit') do
  volunteer = Volunteer.find(params.fetch("id").to_i)
  name = params.fetch('name')
  volunteer.update({:name => name})
  @volunteer = Volunteer.find(params.fetch("id").to_i)
  project_id = @volunteer.project_id
  @project = Project.find(project_id)
  erb(:volunteer)
end

delete('/volunteers/:id/delete') do
  volunteer = Volunteer.find(params.fetch("id").to_i)
  project_id = volunteer.project_id
  @project = Project.find(project_id)
  volunteer.delete
  erb(:project)
end

get('/search_stuff') do
  project_search = params.fetch('parameter')
  @project_results = Project.project_search(project_search)
  erb(:project_searches)
end

get('/volunteer_search') do
  volunteer_search = params.fetch('search_peeps')
  @volunteer_results = Volunteer.volunteer_search(volunteer_search)
  erb(:volunteer_searches)
end
