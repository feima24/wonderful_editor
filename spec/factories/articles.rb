# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: Random.new.rand(1..6)).truncate(30, omission: "") }
    association :user
  end
end
