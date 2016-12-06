require 'rails_helper'

describe MessagesController do

  describe "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    it "GET index" do
      get :index, params: { user_id: user.id }
      expect(response).to render_template(:index)
    end
  end


end
