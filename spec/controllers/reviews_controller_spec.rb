require 'rails_helper'

describe ReviewsController do

  describe "guest user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:review) { FactoryGirl.create(:review, reviewee: user)}

    describe "Get new" do
      it "it needs to be authenticated" do
        get :new, params: { user_id: user }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "Post create user review" do
      it "it needs to be authenticated" do
        post :create, params: { user_id: user }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "Get index" do
      it "it needs to be authenticated" do
        get :index, params: { user_id: user }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "Get edit" do
      it "it needs to be authenticated" do
        get :edit, params: { user_id: user, id: review }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update" do
      it "it needs to be authenticated" do
        patch :update, params: { user_id: user, id: review }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    let(:reviewee) { FactoryGirl.create(:user) }
    let(:review) { FactoryGirl.attributes_for(:review, reviewee: reviewee) }

    describe "Get new" do
      it "renders new template" do
        get :new, params: { user_id: user }
        expect(response).to render_template(:new)
      end
    end

    describe "Post create user review" do
      it "renders user show template" do
        post :create, params: { user_id: reviewee, review: review }
        expect(response).to redirect_to(user_path(reviewee))
      end

      it "creates new review in database" do
        expect {
          post :create, params: { user_id: reviewee, review: review }
        }.to change(Review, :count).by(1)
      end
    end

    describe "Get index" do
      it "list reviews" do
        get :index, params: { user_id: user }
        expect(response).to render_template(:index)
      end
    end

    describe "Get edit" do
      let(:review) { FactoryGirl.create(:review, reviewee: reviewee) }

      it "renders edit template" do
        get :edit, params: { user_id: user, id: review }
        expect(response).to render_template(:edit)
      end
    end

    describe "PUT update" do
      let(:review) { FactoryGirl.create(:review, reviewee: reviewee) }
      let(:new_review) { FactoryGirl.attributes_for(:review, reviewee: reviewee) }

      it "render index template" do
        patch :update, params: { user_id: reviewee, id: review, review: new_review }
        expect(response).to redirect_to(user_reviews_url(reviewee))
      end
    end
  end
end
