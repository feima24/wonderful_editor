require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, updated_at: 1.days.ago) } # rubocop:disable RSpec/IndexedLet
    let!(:article2) { create(:article, updated_at: 2.days.ago) } # rubocop:disable RSpec/IndexedLet
    let!(:article3) { create(:article) } # rubocop:disable RSpec/IndexedLet

    it "記事の一覧が取得できる" do # rubocop:disable RSpec/MultipleExpectations
      subject
      res = response.parsed_body
      expect(response).to have_http_status(:ok)
      expect(res.length).to eq 3
      expect(res.pluck("id")).to eq [article3.id, article1.id, article2.id]
      expect(res[0].keys).to eq ["id", "title", "updated_at", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name", "email"]
    end
  end
end
