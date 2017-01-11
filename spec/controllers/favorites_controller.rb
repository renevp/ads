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
      it "needs to be authenticated" do
        post :create
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE" do
      it "needs to be authenticated" do
        delete :destroy, params: { id: 1 }
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
        favorite = FactoryGirl.create(:favorite, user: user)
        get :index

        assigns(:favorites).each do | f |
          expect(f.user).to eq(user)
        end
      end
    end

    describe "POST Create" do
      let(:favorite) { FactoryGirl.attributes_for(:favorite) }

      pending "creates new favorite in database" do
        expect {
          post :create, params: { favorite: favorite }
        }.to change(Favorite, :count).by(1)
      end
    end

  end

end
