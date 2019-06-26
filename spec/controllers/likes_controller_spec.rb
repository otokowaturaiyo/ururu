require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe '商品の詳細ページ' do
    before do
      @product = FactoryBot.create(:product)
        get :show, params: {id: @product.id}
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      sign_in @user1
    end
    context 'ログインしていない場合' do
      it 'いいねを押せないようになっている' do
        visit product_path(@product.id)
        expect(page).to_not have_button 'Save'
      end
    end
    context 'ログインしている場合' do
        it 'いいねを押せる' do
          find('.like-box-of').click 'save'
      end
        it 'いいねを外せる' do
         visit  product_path(@product.id)
         find('.like-box').click 'destroy'
      end
    end
  end
end

