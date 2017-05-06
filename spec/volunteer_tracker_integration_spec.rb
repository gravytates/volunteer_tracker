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
