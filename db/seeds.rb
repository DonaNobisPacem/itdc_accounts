# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TransactionType.create(title: "Credit")
TransactionType.create(title: "Debit")

case Rails.env
  when "development"
    AccountType.create(title: "AccountType 1")
    AccountType.create(title: "AccountType 2")
    AccountType.create(title: "AccountType 3")
    AccountType.create(title: "AccountType 4")
    AccountType.create(title: "AccountType 5")

    100.times do
      User.create(
        email: FFaker::Internet.email,
        password: "pass1234",
        first_name: FFaker::Name.first_name,
        last_name: FFaker::Name.last_name
        )
    end
end