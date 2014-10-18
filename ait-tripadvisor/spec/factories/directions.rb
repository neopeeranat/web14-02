# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :direction do
    origin_id 1
    destination_id 1
    travelmode nil
    user nil
    price "9.99"
    price ""
  end
end
