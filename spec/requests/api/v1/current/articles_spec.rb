require "rails_helper"

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe "GET /api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context "複数の記事が存在するとき" do
      let!(:article1) { create(:article, :published, user: current_user, updated_at: 1.day.ago) } # rubocop:disable RSpec/IndexedLet
      let!(:article2) { create(:article, :published, user: current_user, updated_at: 2.days.ago) } # rubocop:disable RSpec/IndexedLet
      let!(:article3) { create(:article, :published, user: current_user) } # rubocop:disable RSpec/IndexedLet

      before do
        create(:article, :draft, user: current_user)
        create(:article, :published)
      end

      it "自分の書いた公開記事を更新順に取得できる" do # rubocop:disable RSpec/MultipleExpectations
        subject
        res = response.parsed_body
        expect(res.length).to eq 3
        expect(res.pluck("id")).to eq [article3.id, article1.id, article2.id]
        expect(res[0]["user"]["id"]).to eq current_user.id
        expect(res[0]["user"]["name"]).to eq current_user.name
        expect(res[0]["user"]["email"]).to eq current_user.email
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
