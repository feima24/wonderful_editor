# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Article, type: :model do
  context "タイトルが存在するとき" do
    let(:article) { build(:article) }

    it "記事が作成される" do
      expect(article).to be_valid
    end
  end

  context "タイトルが空のとき" do
    let(:article) { build(:article, title: nil) } # タイトルをnilに設定

    it "記事が作成されない" do
      expect(article).not_to be_valid # タイトルが空の場合、無効であることを期待する
    end

    it "エラーメッセージが表示される" do
      article.valid?
      expect(article.errors.messages[:title]).to include("can't be blank")
    end
  end
end
