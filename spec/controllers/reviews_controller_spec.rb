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
    let(:review) { FactoryGirl.create(:review, reviewee: reviewee)}

    describe "Get new" do
      it "renders new template" do
        get :new, params: { user_id: user }
        expect(response).to redirect_to(new_user_review_url)
      end
    end

    describe "Post create user review" do
      it "renders show template" do
        post :create, params: { user_id: user }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    # describe "Get index" do
    #   it "it needs to be authenticated" do
    #     get :index, params: { user_id: user }
    #     expect(response).to redirect_to(new_user_session_url)
    #   end
    # end
    #
    # describe "Get edit" do
    #   it "it needs to be authenticated" do
    #     get :edit, params: { user_id: user, id: review }
    #     expect(response).to redirect_to(new_user_session_url)
    #   end
    # end
    #
    # describe "PUT update" do
    #   it "it needs to be authenticated" do
    #     patch :update, params: { user_id: user, id: review }
    #     expect(response).to redirect_to(new_user_session_url)
    #   end
    # end
  end
end
