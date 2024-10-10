require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  let(:comment) { create(:comment, user: user, article: article) }

  context "全ての属性が正しく関連付けられている場合" do
    it "ユーザーは記事にコメントできる" do
      expect(comment).to be_valid
    end
  end

  context "user_idがない場合" do
    it "ユーザーは記事にコメントできない" do # rubocop:disable RSpec/MultipleExpectations
      comment = build(:comment, user: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:user_id]).to include("can't be blank")
    end
  end

  context "article_idがない場合" do
    it "ユーザーは記事にコメントできない" do # rubocop:disable RSpec/MultipleExpectations
      comment = build(:comment, article: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:article_id]).to include("can't be blank")
    end
  end

  context "bodyがない場合" do
    it "ユーザーは記事にコメントできない" do # rubocop:disable RSpec/MultipleExpectations
      comment = build(:comment, body: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include("can't be blank")
    end
  end
end
