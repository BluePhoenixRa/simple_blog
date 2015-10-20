require 'rails_helper'
require 'support/macros'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #edit" do
    before do
      @jane = User.create(email: "jane@test.com", password: "password")
    end

    context "Article owner is allowed to edit own articles" do
      it "Renders the Edit form" do
        login_user @jane
        article = Article.create(title: "Alpha Article", body: "Body of alpha article", user: @jane)

        get :edit, id: article

        expect(response).to render_template :edit
      end
    end

    context "If Article doesn't belong to User, they should not be able to edit article" do
      it "Redirects to root_path" do
        bob = User.create(email: "bob@bob.com", password: "password")

        login_user bob

        article = Article.create(title: "Alpha Article", body: "Body of alpha article", user: @jane)

        get :edit, id: article
        expect(response).to redirect_to(root_path)
        message = "You can only edit your own articles."
        expect(flash[:danger]).to eq message
      end
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
