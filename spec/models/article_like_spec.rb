# == Schema Information
#
# Table name: article_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_article_likes_on_article_id  (article_id)
#  index_article_likes_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe ArticleLike, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  context "全ての属性が正しく関連付けられている場合" do
    it "ユーザーは記事に「いいね」を押せる" do
      article_like = build(:article_like, user: user, article: article)
      expect(article_like).to be_valid
    end
  end

  context "user_idが存在しない場合" do
    it "ユーザーは記事に「いいね」を押せない" do # rubocop:disable RSpec/MultipleExpectations
      article_like = build(:article_like, user: nil, article: article)
      expect(article_like).to be_invalid
      expect(article_like.errors[:user]).to include("must exist")
    end
  end

  context "article_idが存在しない場合" do
    it "ユーザーは記事に「いいね」を押せない" do # rubocop:disable RSpec/MultipleExpectations
      article_like = build(:article_like, user: user, article: nil)
      expect(article_like).to be_invalid
      expect(article_like.errors[:article]).to include("must exist")
    end
  end

  context "user_idとarticle_idの組み合わせが重複する場合" do
    before do
      create(:article_like, user: user, article: article)
    end

    it "ユーザーは記事に「いいね」を押せない" do # rubocop:disable RSpec/MultipleExpectations
      duplicate_like = build(:article_like, user: user, article: article)
      expect(duplicate_like).to be_invalid
      expect(duplicate_like.errors[:user_id]).to include("has already been taken")
    end
  end

  context "同じユーザーが異なる記事にいいねする場合" do
    let(:another_article) { create(:article) }

    it "ユーザーは記事に「いいね」を押せる" do
      create(:article_like, user: user, article: article)
      another_like = build(:article_like, user: user, article: another_article)
      expect(another_like).to be_valid
    end
  end

  context "異なるユーザーが同じ記事にいいねする場合" do
    let(:another_user) { create(:user) }

    it "ユーザーは記事に「いいね」を押せる" do
      create(:article_like, user: user, article: article)
      another_like = build(:article_like, user: another_user, article: article)
      expect(another_like).to be_valid
    end
  end
end
