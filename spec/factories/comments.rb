FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(word_count: 1) }
    user
    article
  end
end
