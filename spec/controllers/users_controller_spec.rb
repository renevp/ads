require "rails_helper"

describe UsersController do

  describe "guest user" do
    describe "GET show" do
      context "active user" do
        let(:user) { FactoryGirl.create(:user)}

        it "renders :show template" do
          get :show, params: { id: user }
          expect(response).to render_template(:show)
        end

        it "assigns requested user to @user" do
          get :show, params: { id: user }
          expect(assigns(:user)).to eq(user)
        end
      end
    end

    describe "DELETE destroy" do
      it "redirects to login page" do
        delete :destroy, params: { id: FactoryGirl.create(:user) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in(user)
    end

    context "is not the owner of the user account" do

      describe "DELETE destroy" do
        it "redirects to user page" do
          delete :destroy, params: { id: FactoryGirl.create(:user) }
          expect(response).to redirect_to(user_path)
        end
      end
    end

    context "is the owner of the account user" do

      describe "DELETE destroy" do
        it "redirects to user#index" do
          delete :destroy, params: { id: user }
          expect(response).to redirect_to(user_path)
        end

        it "desactivates user" do
          delete :destroy, params: { id: user }
          user.reload
          expect(user.status).to eq('inactive')
        end

      end

    end
  end
end
