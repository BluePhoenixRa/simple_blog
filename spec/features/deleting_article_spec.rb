require 'rails_helper'

RSpec.feature "Deleting Article" do
  before do
    @article = Article.create(title: "Alpha Article to Delete", body: "Body of alpha article")
  end

  scenario "User deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
