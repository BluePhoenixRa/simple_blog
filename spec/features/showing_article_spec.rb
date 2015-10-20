require 'rails_helper'

RSpec.feature "Show Article" do
  before do
    @jane = User.create(email: "jane@test.com", password: "password")
    @bob = User.create(email: "bob@bob.com", password: "password")
    @article = Article.create(title: "Alpha Article", body: "Body of alpha article", user: @jane)
  end

  scenario "Owner of Article will see Edit and Delete buttons" do
    login_as(@jane)

    visit "/"

    click_link @article.title

    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end

  scenario "Users must log in to see Edit or Delete buttons" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "If Article doesn't belong to User, they should not see Edit or Delete buttons" do
    login_as(@bob)

    visit "/"

    click_link @article.title

    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "Display individual article" do
    visit "/"

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
