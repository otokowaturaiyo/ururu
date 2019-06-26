require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'index' do
    before do
      get :index
      @products = FactoryBot.build_list :product, 25
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '商品一覧が表示されること' do
      expect().to match_array @products
    end
  end

  describe 'show' do
    before do
      @product = FactoryBot.create(:product)
      get :show, params: {id: @product.id}
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '必要な商品情報を表示していること' do
      expect(response).to have_content @product.product_name
      expect(response).to have_content @product.description
      expect(response).to have_content @product.price
      expect(response).to have_content @product.artist.name
      expect(response).to have_content @product.product_name
      expect(response).to have_content @product.product_name
    end
      # Viewの話
      # it 'カートへのリンクがあること' do
      #   expect(response).to have_link "カートに追加する", href: cart_path
      # end
      # it 'いいねが表示されていること' do
      #   expect(response.status).to eq 200
      # end
      # it 'レビュー一覧が表示されていること' do
      #   expect(response.status).to eq 200
      # end
  end
  describe 'feature' do
    before do
      get :feature
      @products = FactoryBot.build_list :product, 25
    end
  end
end
