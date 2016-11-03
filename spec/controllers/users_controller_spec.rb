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

      context "inactive user" do
        let(:user) { FactoryGirl.create(:inactive_user)}
        it "doesn't render :show template if the user is inactive" do
          get :show, params: { id: user }
          expect(response).to redirect_to(advertisements_path)
        end
      end
    end

    describe "POST create" do
      let(:valid_data) { FactoryGirl.attributes_for(:user) }

      context "valid data" do
        it "redirects to user#show" do
          post :create, params: { user: valid_data }
          expect(response).to redirect_to(user_path(assigns[:user]))
        end

        it "creates new user in database" do
          expect {
            post :create, params: { user: valid_data }
          }.to change(User, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) { FactoryGirl.attributes_for(:user, username: '') }

        it "renders :new template" do
          post :create, params: { user: invalid_data }
          expect(response).to render_template(:new)
        end
        it "doesn't create new user in the database" do
          expect {
            post :create, params: { user: invalid_data }
          }.not_to change(User, :count)
        end
      end
    end

    describe "GET edit" do
      it "redirects to login page" do
        get :edit, params: { id: FactoryGirl.create(:user) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update" do
      it "redirects to login page" do
        put :update, params: {id: FactoryGirl.create(:user), user: FactoryGirl.attributes_for(:user) }
        expect(response).to redirect_to(new_user_session_url)
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
      describe "GET edit" do
        it "redirects to user page" do
          get :edit, params: { id: FactoryGirl.create(:user) }
          expect(response).to redirect_to(user_path)
        end
      end

      describe "PUT update" do
        it "redirects to user page" do
          put :update, params: { id: FactoryGirl.create(:user), user: FactoryGirl.attributes_for(:user) }
          expect(response).to redirect_to(user_path)
        end
      end

      describe "DELETE destroy" do
        it "redirects to user page" do
          delete :destroy, params: { id: FactoryGirl.create(:user) }
          expect(response).to redirect_to(user_path)
        end
      end
    end
  end
end
