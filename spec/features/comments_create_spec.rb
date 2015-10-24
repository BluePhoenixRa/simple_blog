require 'rails_helper'

RSpec.feature "Users can add comments to Articles" do
  before do
    @jane = User.create(email: "jane@test.com", password: "password")
    @bob = User.create(email: "bob@bob.com", password: "password")

    @article = Article.create(title: "Alpha Article", body: "Body of Alpha Article", user: @jane)
  end

  scenario "Allow signed in users to comment" do
    login_as(@bob)

    visit "/"
    click_link @article.title
    fill_in "New Comment", with: "I love alpha article! 10/10"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been added")
    expect(page).to have_content("I love alpha article! 10/10")
    expect(current_path).to eq(article_path(@article.id))
  end

end
