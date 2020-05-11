FactoryBot.define do
  factory :student_profile do
    name { Faker::Name.name }
    user
  end
end
