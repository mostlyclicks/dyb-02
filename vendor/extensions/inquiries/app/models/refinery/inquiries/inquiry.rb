
module Refinery
  module Inquiries
    class Inquiry < Refinery::Core::BaseModel
      self.table_name = 'refinery_inquiries'


      alias_attribute :message, :additional_comments

      alias_attribute :name, :first_name

      # Add some validation here if you want to validate the user's input
      # We have validated the first string field for you.
      validates :first_name, :presence => true
    end
  end
end
