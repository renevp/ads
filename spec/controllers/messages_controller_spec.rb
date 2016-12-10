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
          get :edit, params: { user_id: 1, id: message.id }
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "PUT update" do
      it "messages can't be updated" do
        expect {
          put :update, params: { user_id: 1, id: message.id }
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe "guest user" do

    it_behaves_like "edited/updated messages"

    describe "GET index" do
      it "needs to be an authenticated user, so it is redirected" do
        get :index, params: { user_id: 1 }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET show" do
      it "needs to be an authenticated user, so it is redirected" do
        get :show, params: {user_id: recipient.id, id: message.id }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET new" do
      it "needs to be an authenticated user, so it is redirected" do
        get :new, params: { user_id: 1 }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST create" do
      it "needs to be an authenticated user, so it is redirected" do
        post :create, params: { user_id: 1 }
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
        get :index, params: { user_id: user.id }
        expect(response).to render_template(:index)
      end

      pending "shows user messages"
    end

    describe "GET show" do
      it "renders :show template" do
        get :show, params: {user_id: user.id, id: message.id }
        expect(response).to render_template(:show)
      end

      it "assigns requested Message to @message" do
        get :show, params: { user_id: user.id, id: message.id }
        expect(assigns(:message)).to eq(message)
      end
    end

    describe "GET new" do
      it "renders :new template" do
        get :new, params: { user_id: recipient.id }
        expect(response).to render_template(:new)
      end

      it "assigns new Message to @message" do
        get :new, params: { user_id: recipient.id }
        expect(assigns(:message)).to be_a_new(Message)
      end
    end

    describe "POST create" do

      context "valid data" do
        let(:valid_data) { FactoryGirl.attributes_for(:message, sender: sender, recipient: recipient, advertisement: ad, title: 'Message 1') }
        it "redirects to messages#show" do
          post :create, params: { user_id: recipient.id, message: valid_data }
          expect(response).to redirect_to(user_message_path(user, assigns[:message]))
        end

        it "creates new message in database" do
          expect {
            post :create, params: { user_id: recipient.id, message: valid_data }
          }.to change(Message, :count).by(1)
        end
      end

      context "invalid data" do
        let(:invalid_data) { FactoryGirl.attributes_for(:message, sender: sender, recipient: recipient, advertisement: ad, title: '') }
        it "renders :new template" do
          post :create, params: { user_id: recipient.id, message: invalid_data }
          expect(response).to render_template(:new)
        end

        it "doesn't create new message in the database" do
          expect {
            post :create, params: { user_id: recipient.id, message: invalid_data }
          }.not_to change(Message, :count)
        end
      end
    end

    context "is not the owner of the message" do
      describe "DELETE destroy" do
        it "redirects to messages page" do
          delete :destroy, params: { user_id: recipient.id, id: FactoryGirl.create(:message, sender: sender, recipient: recipient, advertisement: ad) }
          expect(response).to redirect_to(user_messages_path)
        end
      end
    end

    context "is the owner of the message" do
      describe "DELETE destroy" do
        it "redirects to messages page" do
          delete :destroy, params: { user_id: recipient.id, id: FactoryGirl.create(:message, sender: sender, recipient: recipient, advertisement: ad) }
          expect(response).to redirect_to(user_messages_path)
        end

        it "deletes message from database" do
          delete :destroy, params: { user_id: recipient.id, id: message }
          expect(Message.exists?(message.id)).to be_falsy
        end
      end
    end
  end

end
