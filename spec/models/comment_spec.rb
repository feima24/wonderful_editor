# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
      expect(comment.errors[:user]).to include("must exist")
    end
  end

  context "article_idがない場合" do
    it "ユーザーは記事にコメントできない" do # rubocop:disable RSpec/MultipleExpectations
      comment = build(:comment, article: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:article]).to include("must exist")
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
