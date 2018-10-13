# encoding: utf-8
require "spec_helper"

module Refinery
  module Inquiries
    describe "inquiries", type: :feature do

      before(:each) do
        Refinery::Inquiries::Engine::load_seed
      end

      describe "Create inquiry" do

        before do
          visit refinery.new_inquiries_inquiry_path
        end

        it "should create a new item" do
          fill_in "inquiry_first_name", :with => "Test"
          fill_in "inquiry_last_name", :with => "Test"
          fill_in "inquiry_email", :with => "Test"
          fill_in "inquiry_phone", :with => "Test"
          fill_in "inquiry_additional_comments", :with => "Test"

          click_button ::I18n.t('.refinery.inquiries.inquiries.new.send')

          expect(page).to have_content("Thank You")
          expect(Refinery::Inquiries::Inquiry.count).to eq(1)
        end
      end
    end
  end
end

