require "rails_helper"

RSpec.describe ArticleLike, type: :model do
  context "まだ「いいね」してない場合" do
    let(:article_like) { build(:article_like) }

    it "そのユーザーは記事に「いいね」できる" do
      expect(article_like).to be_valid
    end
  end

  context "既に「いいね」している場合" do
    let!(:existing_article_like) { create(:article_like) } # すでに「いいね」されている状態
    let(:article_like) { build(:article_like, user: existing_article_like.user, article: existing_article_like.article) }

    it "そのユーザーは記事に「いいね」できない" do # rubocop:disable RSpec/MultipleExpectations
      expect(article_like).not_to be_valid
      expect(article_like.errors[:user_id]).to include("has already been taken") # ユーザーIDの重複エラーメッセージを確認
    end
  end
end
