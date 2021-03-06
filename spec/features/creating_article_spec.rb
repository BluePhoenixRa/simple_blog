require 'rails_helper'

RSpec.feature "Creating New Article" do

  before do
    @jane = User.create!(email: "jane@test.com", password: "password")
    login_as(@jane)
  end

  scenario "User creates new blog article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "First Article"
    fill_in "Body", with: "This is body of the first article."
    click_button "Create Article"

    expect(page).to have_content("New article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@jane.email}")
  end

  scenario "User fails to create new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Article"

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end
