FactoryBot.define do
  factory :section do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph(sentence_count: 4) }
    position { srand % 1000000 }
    course { nil }
  end
end
