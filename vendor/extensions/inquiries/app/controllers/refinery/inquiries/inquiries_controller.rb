module Refinery
  module Inquiries
    class InquiriesController < ::ApplicationController

      before_action :find_page, :only => [:create, :new]

      def index
        redirect_to refinery.new_inquiries_inquiry_path
      end

      def thank_you
        @page = Refinery::Page.where(link_url: "/inquiries/thank_you").first
      end

      def new
        @inquiry = Inquiry.new
      end

      def create
        @inquiry = Inquiry.new(inquiry_params)

        if @inquiry.save
          begin
            Mailer.notification(@inquiry, request).deliver_now
          rescue => e
            logger.warn "There was an error delivering the inquiry notification.\n#{e.message}\n"
          end

          if Inquiry.column_names.map(&:to_s).include?('email')
            begin
              Mailer.confirmation(@inquiry, request).deliver_now
            rescue => e
              logger.warn "There was an error delivering the inquiry confirmation:\n#{e.message}\n"
            end
          else
            logger.warn "Please add an 'email' field to Inquiry if you wish to send confirmation emails when forms are submitted."
          end

          redirect_to refinery.thank_you_inquiries_inquiries_path
        else
          render :action => 'new'
        end
      end

      protected

      def find_page
        @page = Refinery::Page.where(link_url: "/inquiries/new").first
      end

      private

    # Only allow a trusted parameter "white list" through.
      def inquiry_params
        params.require(:inquiry).permit(:first_name, :last_name, :email, :phone, :additional_comments)
      end
    end
  end
end
