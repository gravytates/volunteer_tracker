require "capybara/rspec"
require "spec_helper"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new project', {:type => :feature}) do
  it('allows a user to add a project to the website') do
    visit('/')

    fill_in('name', :with =>'Riparian Restoration')

    click_button('add project')
    expect(page).to have_content('Riparian Restoration')
  end
end

describe('updating a project name', {:type => :feature}) do
  it('allows a user to change a project name') do
    @project1 = Project.new({:name => 'Riparian Restoration', :id => nil})
    @project1.save
    visit("/projects/#{@project1.id}")

    fill_in('name', :with =>'Otter Survey')

    click_button('edit')
    expect(page).to have_content('update project name')
  end
end

describe('adding a volunteer', {:type => :feature}) do
  it('allows a user to change a project name') do
    @project1 = Project.new({:name => 'Riparian Restoration', :id => nil})
    @project1.save
    visit("/projects/#{@project1.id}")

    fill_in('name', :with =>'Fred')

    click_button('add volunteer')
    expect(page).to have_content('Riparian Restoration')
  end
end

describe('adding a volunteer', {:type => :feature}) do
  it('allows a user to change a project name') do
    @project1 = Project.new({:name => 'Riparian Restoration', :id => nil})
    @project1.save
    visit("/projects/#{@project1.id}")

    fill_in('name', :with =>'Fred')

    click_button('add volunteer')
    expect(page).to have_content('Riparian Restoration')
  end
end

describe('sorting projects alphabetically', {:type => :feature}) do
  it('allows a user view projects alphabetically') do
    @project1 = Project.new({:name => 'Riparian Restoration', :id => nil})
    @project1.save
    @project2 = Project.new({:name => 'Alligator wrangling', :id => nil})
    @project2.save
    visit("/")

    click_button('alphabetically')
    expect(page).to have_content('Alligator wrangling')
  end
end

describe('search projects by name', {:type => :feature}) do
  it('allows a user search projects by name') do
    @project1 = Project.new({:name => 'Riparian Restoration', :id => nil})
    @project1.save
    @project2 = Project.new({:name => 'Alligator wrangling', :id => nil})
    @project2.save
    visit("/")
    fill_in('parameter', :with => "Rip")
    click_button('find projects')
    expect(page).to have_content('Riparian Restoration')
  end
end

describe('search volunteers', {:type => :feature}) do
  it('allows a user to search for volunteers by name') do
    volunteer = Volunteer.new({:name => "Joe", :hours => 0, :project_id => 1, :id => nil})
    volunteer.save
    volunteer2 = Volunteer.new({:name => "Fred", :hours => 0, :project_id => 1, :id => nil})
    volunteer2.save
    visit("/")
    fill_in('search_peeps', :with => "Fr")
    click_button('find volunteers')
    expect(page).to have_content('Fred')
  end
end
