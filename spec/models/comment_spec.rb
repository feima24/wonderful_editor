require "rails_helper"

RSpec.describe Comment, type: :model do
  context "コメントが1文字以上ある時" do
    let(:comment) { build(:comment) }

    it "ユーザーは記事にコメントできる" do
      expect(comment).to be_valid
    end
  end

  context "コメントが空の時" do
    let(:comment) { build(:comment, body: nil) } # コメントが空に設定される

    it "ユーザーは記事にコメントできる" do
      expect(comment).not_to be_valid
      expect(comment.errors.messages[:body]).to include("can't be blank", "is too short (minimum is 1 character)")
    end
  end
end
