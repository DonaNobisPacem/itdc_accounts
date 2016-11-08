FactoryGirl.define do
  factory :account do
    account_type 1
    beginning_amount "9.99"
    balance "9.99"
    user nil
  end
end
