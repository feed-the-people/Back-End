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
    email { Faker::Internet.free_email }

		trait :with_recipes do
    	after(:create) do |user|
      create_list(:recipe, 3, user: user)
      end
		end
	end
end
