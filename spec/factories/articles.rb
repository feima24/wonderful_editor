FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: Random.new.rand(1..6)).truncate(30, omission: "") }
    association :user
  end
end
