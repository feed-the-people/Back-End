FactoryBot.define do
    factory :user do
        image { Faker::Avatar.image(slug: "my-own-slug", size: "50x50") }
        username { Faker::Superhero.name }
        password { '1234' }
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        street { Faker::Address.street_name }
        city { Faker::Address.city }
        state { Faker::Address.state_abbr }
        zip { Faker::Address.zip }
        billing_info { Faker::Stripe.valid_card }
    end
  end