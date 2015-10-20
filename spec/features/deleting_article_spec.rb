require 'rails_helper'

RSpec.feature "Deleting Article" do
  before do
    jane = User.create(email: "jane@test.com", password: "password")
    login_as(jane)
    @article = Article.create(title: "Alpha Article to Delete", body: "Body of alpha article", user: jane)
  end

  scenario "User deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
