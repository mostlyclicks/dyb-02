require "spec_helper"

module Refinery
  module Inquiries

    describe "Inquiries request specs", type: :request do

      before(:each) do
        Refinery::Inquiries::Engine.load_seed
      end

      it "successfully gets the index path as redirection" do
        get("/inquiries")
        expect(response).to be_redirect
        expect(response).to redirect_to("/inquiries/new")
      end

      it "successfully gets the new path" do
        get("/inquiries/new")
        expect(response).to be_success
        expect(response).to render_template(:new)
      end

      it "successfully gets the thank_you path" do
        get("/inquiries/thank_you")
        expect(response).to be_success
        expect(response).to render_template(:thank_you)
      end

    end
  end
end
