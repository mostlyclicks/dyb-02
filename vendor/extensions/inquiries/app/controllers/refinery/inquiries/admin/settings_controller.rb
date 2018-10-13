module Refinery
  module Inquiries
    module Admin
      class SettingsController < Refinery::AdminController

        before_action :find_setting, :only => [:edit, :update]
        after_action :save_subject_for_confirmation, :save_message_for_confirmation, :save_notification_recipients, :only => :update

        def edit
        end

        def update
          flash[:notice] = t('refinery.crudify.updated', what: @setting.name.gsub("inquiry_", "").titleize)

          if request.xhr? or from_dialog?
            render html: "<script type='text/javascript'>parent.window.location = '#{refinery.inquiries_admin_inquiries_path}';</script>".html_safe
          else
            redirect_back_or_default(refinery.inquiries_admin_inquiries_path)
          end
        end

      protected
        def find_setting
          setting = params[:id].gsub("inquiry_", "")

          Refinery::Inquiries::Setting.send(setting) if Refinery::Inquiries::Setting.respond_to?(setting)

          @setting = Refinery::Setting.friendly.find(params[:id])
        end

        def save_notification_recipients
          Refinery::Inquiries::Setting.notification_recipients = setting_params[:value] if setting_params.include?('value')
        end

        def save_subject_for_confirmation
          Refinery::Inquiries::Setting.confirmation_subject = setting_params[:subject] if setting_params.include?('subject')
        end

        def save_message_for_confirmation
          Refinery::Inquiries::Setting.confirmation_message = setting_params[:message] if setting_params.include?('message')
        end

        private

        def setting_params
          params.require(:setting).permit(:value,
            subject: Refinery::I18n.frontend_locales,
            message: Refinery::I18n.frontend_locales)
        end
      end
    end
  end
end
