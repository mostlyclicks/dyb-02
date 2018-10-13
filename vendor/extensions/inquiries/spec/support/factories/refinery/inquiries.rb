
FactoryGirl.define do
  factory :inquiry, :class => Refinery::Inquiries::Inquiry do
    sequence(:first_name) { |n| "refinery#{n}" }
  end
end

