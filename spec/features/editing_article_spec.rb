require 'rails_helper'

RSpec.feature "Editing Article" do
  before do
    @article = Article.create(title: "Alpha Article", body: "Body of alpha article")
  end

  scenario "User updates an article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: "Updating Alpha Article"
    fill_in "Body", with: "Updated body of alpha article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "User fails to update article" do
    visit "/"

    click_link @article.title
    click_link "Edit Article"

    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Update Article"

    expect(page).to have_content("Article failed to be updated")
    expect(page.current_path).to eq(article_path(@article))
  end
end
