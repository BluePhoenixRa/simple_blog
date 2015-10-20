require 'rails_helper'

RSpec.feature "Users Signing in" do
  before do
    @jane = User.create!(email: "jane@test.com", password: "password")
  end

  scenario "Sign-in with proper credentials" do
    visit "/"

    click_link "Sign In"
    fill_in "Email", with: @jane.email
    fill_in "Password", with: @jane.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end
end
