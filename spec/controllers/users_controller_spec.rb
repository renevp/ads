require "rails_helper"

describe UsersController do

  shared_examples "public access to user profile" do
    describe "GET show" do
      let(:new_user) { FactoryGirl.create(:user)}
      let(:published_sell_ad) { FactoryGirl.create(:published_sell_ad, user: new_user)}
      let(:published_buy_ad) { FactoryGirl.create(:published_buy_ad, user: new_user)}

      it "renders :show template" do
        get :show, params: { id: new_user }
        expect(response).to render_template(:show)
      end

      it "assigns requested user to @user" do
        get :show, params: { id: new_user }
        expect(assigns(:user)).to eq(new_user)
      end

      it "shows public sell advertisements" do
        get :show, params: { id: new_user }
        expect(assigns(:sell_ads)).to eq([published_sell_ad])
      end

      it "shows public buy advertisements" do
        get :show, params: { id: new_user }
        expect(assigns(:buy_ads)).to eq([published_buy_ad])
      end
    end

  end

  describe "guest user" do
    it_behaves_like "public access to user profile"

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

      it_behaves_like "public access to user profile"

      describe "DELETE destroy" do
        it "redirects to user page" do
          delete :destroy, params: { id: FactoryGirl.create(:user) }
          expect(response).to redirect_to(user_path)
        end
      end
    end

    context "is the owner of the account user" do
      describe "GET show" do
        let(:user) { FactoryGirl.create(:user)}
        let(:created_sell_ad) { FactoryGirl.create(:created_sell_ad, user: user)}
        let(:created_buy_ad) { FactoryGirl.create(:created_buy_ad, user: user)}
        let(:published_sell_ad) { FactoryGirl.create(:published_sell_ad, user: user)}
        let(:published_buy_ad) { FactoryGirl.create(:published_buy_ad, user: user)}
        let(:closed_sell_ad) { FactoryGirl.create(:closed_sell_ad, user: user)}
        let(:closed_buy_ad) { FactoryGirl.create(:closed_buy_ad, user: user)}

        it "renders :show template" do
          get :show, params: { id: user }
          expect(response).to render_template(:show)
        end

        it "assigns requested user to @user" do
          get :show, params: { id: user }
          expect(assigns(:user)).to eq(user)
        end

        it "shows created sell advertisements" do
          get :show, params: { id: user }
          expect(assigns(:sell_ads)).to eq([created_sell_ad])
        end

        it "shows created buy advertisements" do
          get :show, params: { id: user }
          expect(assigns(:buy_ads)).to eq([created_buy_ad])
        end

        it "shows published sell advertisements" do
          get :show, params: { id: user }
          expect(assigns(:sell_ads)).to eq([published_sell_ad])
        end

        it "shows published buy advertisements" do
          get :show, params: { id: user }
          expect(assigns(:buy_ads)).to eq([published_buy_ad])
        end

        it "shows closed sell advertisements" do
          get :show, params: { id: user }
          expect(assigns(:sell_ads)).to eq([closed_sell_ad])
        end

        it "shows closed buy advertisements" do
          get :show, params: { id: user }
          expect(assigns(:buy_ads)).to eq([closed_buy_ad])
        end
      end

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
