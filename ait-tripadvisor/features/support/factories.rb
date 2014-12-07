
FactoryGirl.define do
  factory :ruser, class: User do
    email "msiraj83@gmail.com"
    password "11111111"
    #password_confirmation "11111111"
  end
  factory :nplace, class: Place do
      id '101'
      name "india"
      description "This place is 2 km away from pathaya..."
      category_id '1'
  end
end
