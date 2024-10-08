# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "必要な情報が揃っている場合" do
    let(:user) { build(:user) }

    it "ユーザー登録できる" do
      expect(user).to be_valid
    end
  end

  context "名前のみ入力している場合" do
    let(:user) { build(:user, email: nil, password: nil) }

    it "エラーが発生する" do # rubocop:disable RSpec/MultipleExpectations
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("can't be blank")
      expect(user.errors.messages[:password]).to include("can't be blank")
    end
  end

  context "email がない場合" do
    let(:user) { build(:user, email: nil) }

    it "エラーが発生する" do # rubocop:disable RSpec/MultipleExpectations
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to include("can't be blank")
    end
  end

  context "password がない場合" do
    let(:user) { build(:user, password: nil) }

    it "エラーが発生する" do # rubocop:disable RSpec/MultipleExpectations
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to include("can't be blank")
    end
  end
end
