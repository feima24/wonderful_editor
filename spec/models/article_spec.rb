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
require "rails_helper"

RSpec.describe Article, type: :model do
  let(:user) { create(:user) }

  context "titleが存在するとき" do
    let(:article) { create(:article, user: user) }

    it "記事は作成される" do
      expect(article).to be_valid
    end
  end

  context "titleが存在しないとき" do
    let(:article) { build(:article, title: nil, user: user) }

    it "記事の作成に失敗する" do # rutobocop:disable RSpec/MultipleExpectations # rubocop:disable RSpec/MultipleExpectations
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("can't be blank")
    end
  end
end
