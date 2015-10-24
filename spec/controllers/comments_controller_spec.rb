require 'rails_helper'
require 'support/macros'

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before do
      @jane = User.create(email: "jane@test.com", password: "password")
    end

    context "Signed in user" do
      it "can create a comment" do
        login_user @jane
        article = Article.create(title: "Alpha Article", body: "Body of alpha article", user: @jane)
        post :create, comment: {body: "Alpha article for the win"}, article_id: article.id
        expect(flash[:success]).to eq("Comment has been added")
      end
    end

    context "Users not signed in" do
      it "is redirected to the sign in page" do
        login_user nil
        article = Article.create(title: "Beta Article", body: "Body of beta article", user: @jane)
        post :create, comment: {body: "Beta article is the best"}, article_id: article.id
        expect(response).to redirect_to new_user_session_path
      end
    end



  end
end
