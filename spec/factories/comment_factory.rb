FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.word }
    association(:user)
    association(:movie)
  end
end
