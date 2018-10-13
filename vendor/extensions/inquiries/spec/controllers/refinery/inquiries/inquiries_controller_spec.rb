require "spec_helper"

module Refinery
  module Inquiries
    describe InquiriesController, type: :controller do

      before do
        @route = Refinery::Inquiries::Engine.routes
        Refinery::Inquiries::Engine::load_seed

        @new_page = Refinery::Page.new
        allow(Refinery::Page).to receive_messages(:where => [ @new_page ])
      end

      describe "GET new" do
        it "before_filter assigns a new inquiry" do
          get :new
          expect(assigns(:inquiry)).to be_a_new(Inquiry)
        end
        it "before_filter assigns page to inquiries/new" do
          get :new
          expect(assigns(:page)).to eq @new_page
        end
      end

      describe "POST create" do

        before{
          allow_any_instance_of(Inquiry).to receive(:save).and_return( true )
        }


        it "before_filter assigns page to inquiries/new" do
          post :create, inquiry: {first_name: "foo", last_name: "foo", email: "foo", phone: "foo", }
          expect(assigns(:page)).to eq @new_page
        end

        it "before_filter assigns a new inquiry" do
          post :create, inquiry: {first_name: "foo", last_name: "foo", email: "foo", phone: "foo", }
          expect(assigns(:inquiry)).to be_a_new(Inquiry)
        end

        it "redirects to thank_you" do
          post :create, inquiry: {first_name: "foo", last_name: "foo", email: "foo", phone: "foo", }
          expect(response).to redirect_to "/inquiries/thank_you"
        end

        describe "when it can't save the inquiry" do

          before {
          allow_any_instance_of(Inquiry).to receive(:save).and_return( false )
          }

          it "redirects to new if it can't save" do
            post :create, inquiry: {first_name: "foo", last_name: "foo", email: "foo", phone: "foo", }

            expect(response).to render_template(:new)
          end
        end

      end
    end
  end
end
