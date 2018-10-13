module Refinery
  module Inquiries
    module Admin
      class InquiriesController < Refinery::AdminController

        crudify :'refinery/inquiries/inquiry', 
                :title_attribute => "first_name", 
                :order => "created_at DESC"

        def index
          if searching?
            search_all_inquiries
          else
            find_all_inquiries
          end

          @grouped_inquiries = group_by_date(@inquiries)
        end


        private

        # Only allow a trusted parameter "white list" through.
        def inquiry_params
          params.require(:inquiry).permit(:first_name, :last_name, :email, :phone, :additional_comments)
        end
      end
    end
  end
end
