# encoding: utf-8
require "spec_helper"

module Refinery
  module Inquiries
    module Admin
      describe Inquiry, type: :feature do
        refinery_login_with :refinery_user

       describe "inquiries list" do
          before do
            FactoryGirl.create(:inquiry, :first_name => "UniqueTitleOne")
            FactoryGirl.create(:inquiry, :first_name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.inquiries_admin_inquiries_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

       describe "show" do
         let!(:inquiry) do
            FactoryGirl.create(:inquiry, :first_name => "UniqueTitleOne")
          end

         it "has expected text and menu" do
           visit refinery.inquiries_admin_inquiries_path

           click_link "Read the inquiry"

           expect(page).to have_content("UniqueTitleOne")
           expect(page).not_to have_content("UniqueTitleTwo")

           within "#actions" do
             expect(page).to have_content("Age")
             expect(page).to have_content("Back to all inquiries")
             expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries']")
             expect(page).to have_content("Remove this inquiry forever")
             expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries/#{inquiry.id}']")
           end
         end
       end

       describe "when no " do
         before { Refinery::Inquiries::Inquiry.destroy_all }

         context "inquiries" do
           it "shows expected message" do
            visit refinery.inquiries_admin_inquiries_path

            expect(page).to have_content("You have not received any inquiries yet.")

            end
           end

     end

      describe "action links" do
        before { visit refinery.inquiries_admin_inquiries_path }

        specify "in the side pane" do
          within "#actions" do
            expect(page).to have_content("Inbox")
            expect(page).to have_selector("a[href='/#{Refinery::Core.backend_route}/inquiries']")

            expect(page).to have_content("Update who gets notified")
            expect(page).to have_selector("a[href*='/#{Refinery::Core.backend_route}/inquiries/settings/inquiry_notification_recipients/edit']")
            expect(page).to have_content("Edit confirmation email")
            expect(page).to have_selector("a[href*='/#{Refinery::Core.backend_route}/inquiries/settings/inquiry_confirmation_message/edit']")
          end
        end
      end



        describe "destroy" do
          before { FactoryGirl.create(:inquiry, :first_name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.inquiries_admin_inquiries_path

            click_link "Remove this inquiry forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Inquiries::Inquiry.count).to eq 0
          end
        end

          describe "destroy from inquiry show page" do
          before { FactoryGirl.create(:inquiry, :first_name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.inquiries_admin_inquiry_path( :id => '1')

            click_link "Remove this inquiry forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Inquiries::Inquiry.count).to eq 0
          end
          end

      end
    end
  end
end
