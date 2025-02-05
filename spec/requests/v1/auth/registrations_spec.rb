require "rails_helper"

RSpec.describe "V1::Auth::Registrations", type: :request do
  describe "POST /v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "必要な情報が存在するとき" do
      let(:params) { attributes_for(:user) }
      it "ユーザーの新規登録ができる" do # rubocop:disable RSpec/MultipleExpectations
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        res = response.parsed_body
        expect(res["data"]["email"]).to eq(User.last.email)
      end

      it "header 情報を取得することができる" do # rubocop:disable RSpec/MultipleExpectations
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
      end
    end

    context "name が存在しないとき" do
      let(:params) { attributes_for(:user, name: nil) }
      it "エラーする" do # rubocop:disable RSpec/MultipleExpectations
        expect { subject }.not_to change { User.count }
        res = response.parsed_body
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["name"]).to include "can't be blank"
      end
    end

    context "email が存在しないとき" do
      let(:params) { attributes_for(:user, :without_email) }
      it "エラーする" do # rubocop:disable RSpec/MultipleExpectations
        expect { subject }.not_to change { User.count }
        res = response.parsed_body
        expect(response).to have_http_status(:unprocessable_entity) # 422
        expect(res["errors"]["email"]).to include "can't be blank"
      end
    end

    context "password が存在しないとき" do
      let(:params) { attributes_for(:user, password: nil) }
      it "エラーする" do # rubocop:disable RSpec/MultipleExpectations
        expect { subject }.not_to change { User.count }
        res = response.parsed_body
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["password"]).to include "can't be blank"
      end
    end
  end
end
