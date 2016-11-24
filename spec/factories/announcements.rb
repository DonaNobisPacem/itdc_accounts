FactoryGirl.define do
  factory :announcement do
    subject {FFaker::Lorem.sentence}
    message {FFaker::Lorem.paragraph}
    visible_to_users false
    visible_to_admins false
    start_date "2016-11-24 12:23:15"
  end
end
