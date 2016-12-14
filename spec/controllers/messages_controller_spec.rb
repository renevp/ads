require 'rails_helper'

describe MessagesController do
  let(:sender) { FactoryGirl.create(:user) }
  let(:recipient) { FactoryGirl.create(:user) }
  let(:ad) { FactoryGirl.create(:published_advertisement, user: recipient)}
  let(:message) { FactoryGirl.create(:message, sender: sender, recipient: recipient, advertisement: ad, body: 'Message 1') }

  shared_examples "edited/updated messages" do
    describe "GET edit" do
      it "messages can't be edited" do
        expect {
          get :edit, params: { advertisement_id: ad, id: message.id }
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "PUT update" do
      it "messages can't be updated" do
        expect {
          put :update, params: { advertisement_id: ad, id: message.id }
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe "guest user" do

    it_behaves_like "edited/updated messages"

    describe "GET index" do
      it "needs to be an authenticated user, so it is redirected" do
        get :index, params: { advertisement_id: ad }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET show" do
      it "needs to be an authenticated user, so it is redirected" do
        get :show, params: {advertisement_id: ad, id: message.id }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET new" do
      it "needs to be an authenticated user, so it is redirected" do
        get :new, params: { advertisement_id: ad }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST create" do
      it "needs to be an authenticated user, so it is redirected" do
        post :create, params: { advertisement_id: ad }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "authenticated user" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    it_behaves_like "edited/updated messages"

    describe "GET index" do
      it "renders :index template " do
        get :index, params: { advertisement_id: ad }
        expect(response).to render_template(:index)
      end

      it "shows user messages" do
        message = FactoryGirl.create(:message, sender: user, advertisement: ad)
        get :index, params: { advertisement_id: ad }
        expect(assigns(:messages)).to match_array([message])
      end
    end

    describe "GET show" do
      it "renders :show template" do
        get :show, params: { advertisement_id: ad, id: message.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested Message to @message" do
        get :show, params: { advertisement_id: ad, id: message.id }
        expect(assigns(:message)).to eq(message)
      end
    end

    describe "GET new" do
      it "renders :new template" do
        get :new, params: { advertisement_id: ad }
        expect(response).to render_template(:new)
      end

      it "assigns new Message to @message" do
        get :new, params: { advertisement_id: ad }
        expect(assigns(:message)).to be_a_new(Message)
      end
    end

    describe "POST create" do

      context "valid data" do
        let(:valid_data) { FactoryGirl.attributes_for(:message) }
        it "redirects to messages#index" do
          post :create, params: { advertisement_id: ad, message: valid_data }
          expect(response).to redirect_to(advertisement_messages_path(ad))
        end

        it "creates new message in database" do
          expect {
            post :create, params: { advertisement_id: ad, message: valid_data }
          }.to change(Message, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) { FactoryGirl.attributes_for(:message, body: '') }
        it "renders :new template" do
          post :create, params: { advertisement_id: ad, message: invalid_data }
          expect(response).to render_template(:new)
        end

        it "doesn't create new message in the database" do
          expect {
            post :create, params: { advertisement_id: ad, message: invalid_data }
          }.not_to change(Message, :count)
        end
      end
    end

    context "is not the owner of the message" do
      describe "DELETE destroy" do
        it "redirects to messages page" do
          delete :destroy, params: { advertisement_id: ad, id: message.id }
          expect(response).to redirect_to(advertisement_messages_path)
        end

        it "doesn't delete message from database" do
          delete :destroy, params: { advertisement_id: ad, id: message.id  }
          expect(Message.exists?(message.id)).to be_truthy
        end
      end
    end

    context "is the owner of the message" do
      describe "DELETE destroy" do
        let(:message) { FactoryGirl.create(:message, sender: user) }

        it "redirects to messages page" do
          delete :destroy, params: { advertisement_id: ad, id: message.id }
          expect(response).to redirect_to(advertisement_messages_path)
        end

        it "deletes message from database" do
          delete :destroy, params: { advertisement_id: ad, id: message.id }
          expect(Message.exists?(message.id)).to be_falsy
        end
      end
    end
  end

end
