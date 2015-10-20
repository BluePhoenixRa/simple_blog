require 'rails_helper'

RSpec.feature "Users Signing Out" do
  before do
    @jane = User.create!(email: "jane@test.com", password: "password")
    visit "/"

    click_link "Sign In"
    fill_in "Email", with: @jane.email
    fill_in "Password", with: @jane.password
    click_button "Log in"
  end

  scenario "User clicks Sign Out button" do
    visit "/"

    click_link "Sign Out"
    expect(page).to have_content("Signed out successfully.")
  end
end
