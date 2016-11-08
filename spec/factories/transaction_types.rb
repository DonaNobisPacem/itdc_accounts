FactoryGirl.define do
  factory :transaction_type do
    title {FFaker::Lorem.word}
    description {FFaker::Lorem.paragraph}
  end
end
