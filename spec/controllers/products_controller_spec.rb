require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '商品一覧ページ' do
    context '新着商品が表示される' do
      before do
        get :index
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
    end
  end

end
