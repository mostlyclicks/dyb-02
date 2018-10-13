# encoding: utf-8
require "spec_helper"

module Refinery
  module Inquiries
  describe "Settings", type: :feature do
    refinery_login_with :refinery_user

    describe "update who gets notified" do
      before do
        Rails.cache.clear
        Refinery::Inquiries::Setting.notification_recipients
      end

      it "sets receiver", :js => true do
        visit refinery.inquiries_admin_inquiries_path

        click_link ::I18n.t('update_notified', scope: 'refinery.inquiries.admin.inquiries.submenu')

        within_frame "dialog_iframe" do
          fill_in ::I18n.t('inquiry_settings_value_name', scope: 'refinery.inquiries.admin.settings.notification_recipients_form'), :with => "phil@refinerycms.com"
          click_button "submit_button"
        end

        expect(page).to have_content("Notification Recipients was successfully updated.")
      end
    end

    describe "updating confirmation email copy" do
      before do
        Rails.cache.clear
        Refinery::Inquiries::Setting.confirmation_message
        Refinery::Inquiries::Setting.confirmation_subject
      end

      it "sets subject and message", :js => true do
        visit refinery.inquiries_admin_inquiries_path

        click_link ::I18n.t('edit_confirmation_email', scope: 'refinery.inquiries.admin.inquiries.submenu')

        within_frame "dialog_iframe" do
          fill_in ::I18n.t('subject', scope: 'refinery.inquiries.admin.settings.confirmation_email_form'), :with => "subject"
          fill_in ::I18n.t('message', scope: 'refinery.inquiries.admin.settings.confirmation_email_form'), :with => "message"

          click_button "submit_button"
        end

        expect(page).to have_content("Confirmation Message was successfully updated.")
      end
    end

  end
  end
end
