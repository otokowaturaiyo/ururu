require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @products1 = FactoryBot.create(:product)
    @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
    sign_in @user1
  end
  describe '商品の詳細ページ' do
    before do
      get :show, params: {id: '1'}
    end
    context 'ログインしていない場合' do
      context '押せないようになっている' do
        visit product_path(@products1)
        expect(page).to_not have_button 'Save'
      end
    end
  end
    context 'ログインしている場合' do
      before do
        @products1 = FactoryBot.create(:product)
      end
        context 'いいねを押せる' do
          click_buttun 'save'
      end
        context 'いいねを外せる' do
         visit  product_path(@products1)
         click_buttun 'destroy'
      end
    end
end