require "capybara/rspec"
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
