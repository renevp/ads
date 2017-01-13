require 'rails_helper'

describe FavoritesController do

  describe 'guest user' do
    let(:favorite) { FactoryGirl.create(:favorite) }

    describe 'GET Index' do
      it "needs to be authenticated" do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST Create" do
      let(:ad) { FactoryGirl.create(:advertisement) }

      it "needs to be authenticated" do
        post :create, params: { advertisement_id: ad }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE" do
      it "needs to be authenticated" do
        delete :destroy, params: { id: favorite }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    describe "GET Index" do
      it "should show the index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "shows user favorites" do
        user_favorite = FactoryGirl.create(:favorite, user: user)
        favorite = FactoryGirl.create(:favorite)
        get :index

        assigns(:favorites).each do | f |
          expect(f.user).to eq(user)
        end
      end
    end

    describe "POST Create" do
      let(:ad) { FactoryGirl.create(:advertisement) }

      it "creates new favorite in database" do
        expect {
        post :create, params: { advertisement_id: ad }
        }.to change(Favorite, :count).by(1)
      end
    end

    describe "DELETE destroy" do

      it "remove the favorite from database" do
        user_favorite = FactoryGirl.create(:favorite, user: user)

        delete :destroy, params: { id: user_favorite.id }
        expect(Favorite.exists?(user_favorite.id)).to be_falsy
      end
    end

  end

end
