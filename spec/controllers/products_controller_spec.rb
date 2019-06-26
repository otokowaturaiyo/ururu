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
    # it '商品一覧が表示されること' do
    #   expect().to match_array @products
    # end
  end

  describe 'show' do
    render_views
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
      get :show, params: {id: @product.id}
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it "商品が必要な情報を持っていること" do
      expect(response.body).to have_content @product.product_name
      expect(response.body).to have_content @product.description
      expect(response.body).to have_content @product.price
      expect(response.body).to have_content @product.artist.name
      expect(response.body).to have_content @product.genre.genre
      expect(response.body).to have_content @product.label.label
    end

    it 'カートへのリンクがあること' do
      expect(response.body).to have_link "カートに追加する", href: cart_path
    end

    it 'いいねが表示されていること' do
      expect(response.body).to have_link href: "/products/#{@product.id}/likes"
    end

    it 'レビュー一覧が表示されていること' do
      expect(response.body).to have_text "レビュー一覧"
    end

  end
  describe 'feature' do
    before do
      get :feature
      @products = FactoryBot.build_list :product, 25
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
  end

  describe 'search_list' do
    before do
      get :search_list
    end
    it "リクエストは200 OKとなること" do
      expect(response.status).to eq 200
    end
    it "" do

    end
  end

end
