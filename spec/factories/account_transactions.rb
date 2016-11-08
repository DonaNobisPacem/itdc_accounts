FactoryGirl.define do
  factory :account_transaction do
    transaction_type 1
    amount "9.99"
    prev_balance "9.99"
    new_balance "9.99"
    description "MyText"
    account nil
  end
end
