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
class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy

  validates :title, presence: true

  # stringカラムの場合は、enumの定義を以下のようにします
  enum status: { draft: "draft", published: "published" }

  # draftスコープの定義
  scope :draft, -> { where(status: :draft) }
  scope :published, -> { where(status: "published") }
end
