# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    status { :published } # デフォルトで公開状態に設定
    user

    trait :draft do
      # ステータスが「draft」の場合
      status { "draft" } # ここでstatusを'draft'に設定
    end
  end
end
