require 'rails_helper'

describe AdvertisementsController do

  shared_examples "public access to advertisements" do
    describe "GET Index" do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns only published advertisements to template" do
        published_ad = FactoryGirl.create(:published_advertisement)
        created_ad = FactoryGirl.create(:advertisement)
        get :index
        expect(assigns(:advertisements)).to match_array([published_ad])
      end
    end

    describe "GET show" do
      let(:advertisement) { FactoryGirl.create(:published_advertisement)}

      it "renders :show template" do
        get :show, params: { id: advertisement } 
        expect(response).to render_template(:show)
      end

      it "assigns requested advertisement to @advertisement" do
        get :show, params: { id: advertisement }
        expect(assigns(:advertisement)).to eq(advertisement)
      end
    end
  end

  describe "guest user" do
    it_behaves_like "public access to advertisements"

    describe "GET new" do
      it "redirects to login page" do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "POST create" do
      it "redirects to login page" do
        post :create, params: { advertisement: FactoryGirl.attributes_for(:published_advertisement) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "GET edit" do
      it "redirects to login page" do
        get :edit, params: { id: FactoryGirl.create(:published_advertisement) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "PUT update" do
      it "redirects to login page" do
        put :update, params: {id: FactoryGirl.create(:published_advertisement), advertisement: FactoryGirl.attributes_for(:published_advertisement) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "DELETE destroy" do
      it "redirects to login page" do
        delete :destroy, params: { id: FactoryGirl.create(:published_advertisement) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe "authenticated user" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in(user)
      end

      it_behaves_like "public access to advertisements"

      describe "GET index" do
        it "renders :index template" do
          get :index
          expect(response).to render_template(:index)
        end

        it "assigns only public advertisements to template" do
          published_advertisement = FactoryGirl.create(:published_advertisement)
          created_achievement = FactoryGirl.create(:advertisement)
          get :index
          expect(assigns(:advertisements)).to match_array([published_advertisement])
        end
      end

      describe "GET show" do
        let(:advertisement) { FactoryGirl.create(:published_advertisement)}

        it "renders :show template" do
          get :show, params: { id: advertisement }
          expect(response).to render_template(:show)
        end

        it "assigns requested advertisement to @advertisement" do
          get :show, params: { id: advertisement }
          expect(assigns(:advertisement)).to eq(advertisement)
        end
      end

      describe "GET new" do
        it "renders :new template" do
          get :new
          expect(response).to render_template(:new)
        end

        it "assigns new Advertisement to @advertisement" do
          get :new
          expect(assigns(:advertisement)).to be_a_new(Advertisement)
        end
      end

      describe "POST create" do
        let(:valid_data) { FactoryGirl.attributes_for(:published_advertisement) }

        context "valid data" do
          it "redirects to advertisements#show" do
            post :create, params: { advertisement: valid_data }
            expect(response).to redirect_to(advertisement_path(assigns[:advertisement]))
          end

          it "creates new advertisement in database" do
            expect {
              post :create, params: { advertisement: valid_data }
            }.to change(Advertisement, :count).by(1)
          end
        end

        context "invalid data" do
          let(:invalid_data) { FactoryGirl.attributes_for(:published_advertisement, title: '') }

          it "renders :new template" do
            post :create, params: { advertisement: invalid_data }
            expect(response).to render_template(:new)
          end
          it "doesn't create new advertisement in the database" do
            expect {
              post :create, params: { advertisement: invalid_data }
            }.not_to change(Advertisement, :count)
          end
        end

        context "is not the owner of the advertisement" do
          describe "GET edit" do
            it "redirects to advertisement page" do
              get :edit, params: { id: FactoryGirl.create(:published_advertisement) }
              expect(response).to redirect_to(advertisements_path)
            end
          end

          describe "PUT update" do
            it "redirects to advertisements page" do
              put :update, params: { id: FactoryGirl.create(:published_advertisement), advertisement: FactoryGirl.attributes_for(:published_advertisement) }
              expect(response).to redirect_to(advertisements_path)
            end
          end

          describe "DELETE destroy" do
            it "redirects to advertisements page" do
              delete :destroy, params: { id: FactoryGirl.create(:published_advertisement) }
              expect(response).to redirect_to(advertisements_path)
            end
          end
        end

        context "is the owner of the achievement" do
          let(:advertisement) { FactoryGirl.create(:published_advertisement, user: user) }

          describe "GET edit" do
            it "renders :edit template" do
              get :edit, params: { id: advertisement }
              expect(response).to render_template(:edit)
            end

            it "assigns the requested advertisement to template" do
              get :edit, params: { id: advertisement }
              expect(assigns(:advertisement)).to eq(advertisement)
            end
          end

          describe "PUT update" do
            context "valid data" do
              let(:valid_data) { FactoryGirl.attributes_for(:published_advertisement, title: "New Ad") }

              it "redirects to advertisement#show" do
                put :update, params: { id: advertisement, advertisement: valid_data }
                expect(response).to redirect_to(advertisement)
              end
              it "updates advertisement in the database" do
                put :update, params: { id: advertisement, advertisement: valid_data }
                advertisement.reload
                expect(advertisement.title).to eq("New Ad")
              end
            end

            context "invalid data" do
              let(:invalid_data) { FactoryGirl.attributes_for(:published_advertisement, title: "", description: 'new') }

              it "renders :edit template" do
                put :update, params: { id: advertisement, advertisement: invalid_data }
                expect(response).to render_template(:edit)
              end

              it "doesn't update advertisement in the database" do
                put :update, params: { id: advertisement, advertisement: invalid_data }
                advertisement.reload
                expect(advertisement.description).not_to eq('new')
              end
            end
          end

          describe "DELETE destroy" do
            it "redirects to advertisement#index" do
              delete :destroy, params: { id: advertisement }
              expect(response).to redirect_to(advertisements_path)
            end

            it "deletes advertisements from database" do
              delete :destroy, params: { id: advertisement }
              expect(Advertisement.exists?(advertisement.id)).to be_falsy
            end
          end

        end

      end

    end

  end

end
