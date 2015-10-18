require 'rails_helper'

RSpec.feature "Creating New Posts" do
  scenario "User creates new blog post" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "First Article"
    fill_in "Body", with: "This is body of the first article."
    click_button "Create Article"

    expect(page).to have_content("New article has been created")
    expect(page.current_path).to eq(articles_path)
  end
end