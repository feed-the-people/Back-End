FactoryBot.define do
  factory :recipe do
    title { Faker::Food.dish }
    image { Faker::LoremFlickr.image(size: "50x60", search_terms: ['food']) }
    description { Faker::Food.description }
    instructions { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    charity_id { 1 }
    charity_name { "#{Faker::Company.name} #{Faker::Company.suffix}" }
    user { nil }
  end
end
