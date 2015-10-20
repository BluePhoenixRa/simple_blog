require 'rails_helper'

RSpec.feature "User Signup" do
  scenario "Signing up with credentials" do
    visit "/"

    click_link "Sign Up"
    fill_in "Email", with: "user@test.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
  end
end
