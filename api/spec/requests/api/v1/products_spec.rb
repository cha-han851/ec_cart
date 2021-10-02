# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let(:category) { FactoryBot.create(:category) }
  let(:product) { FactoryBot.create(:product, category) }

  context 'GET /api/v1/products' do
    before { get api_v1_products_path }
    it { expect(response).to have_http_status 200 }
  end

  context 'GET /api/v1/products/:id' do
    before { get api_v1_products_path(product.id) }
    it { expect(response).to have_http_status 200 }
  end
end
