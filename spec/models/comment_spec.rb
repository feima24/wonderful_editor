# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  context "コメントが1文字以上のとき" do
    let(:comment) { build(:comment) }

    it "ユーザーは記事にコメントできる" do
      expect(comment).to be_valid
    end
  end

  context "コメントが空のとき" do
    let(:comment) { build(:comment, body: nil) } # コメントが空に設定される

    it "ユーザーは記事にコメントできない" do
      expect(comment).not_to be_valid
    end

    it "エラーメッセージ表示" do
      comment.valid?
      expect(comment.errors.messages[:body]).to include("can't be blank", "is too short (minimum is 1 character)")
    end
  end
end
