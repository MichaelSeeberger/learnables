FactoryBot.define do
  factory :staff_profile, aliases: [:owner] do
    name { Faker::Name.name }
    user

    factory :admin_profile do
      after :create do |profile|
        profile.user.add_role :admin
      end
    end
  end
end
