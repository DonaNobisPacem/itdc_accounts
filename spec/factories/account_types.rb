FactoryGirl.define do
  factory :account_type do
    title {FFaker::Lorem.word}
    description {FFaker::Lorem.paragraph}
  end
end
