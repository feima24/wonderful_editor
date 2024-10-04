FactoryBot.define do
  factory :article_like do
    association :user
    association :article
  end

  factory :existing_article_like, parent: :article_like do
  end
end
