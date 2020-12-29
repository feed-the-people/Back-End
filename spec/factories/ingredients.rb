FactoryBot.define do
  factory :ingredient do
    recipe { nil }
    name { Faker::Food.ingredient }
    amount { Faker::Food.measurement }
  end
end
