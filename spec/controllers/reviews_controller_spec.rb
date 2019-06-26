require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
	describe '商品の詳細ページ' do
		context 'ログインしていない場合' do
			it 'レビュー投稿はできないようになっている' do
		  end
	   end
  end
    describe 'レビューの編集' do
      before do
        @product = FactroyBot.create(:product)
        @user1 = FactoryBot.create(:user)
          @user2 = FactoryBot.create(:user)
        sign_in @user1
      end


    context 'ログインしていない場合' do
       it 'レビューの編集ページに行けないようになっている' do
        expect(page).to have_no_buttoun
      end
    end
    context 'ログインしている場合' do
      before do
        @product1 = FactroyBot.create(:product)
        @user1 = FactoryBot.create(:user)
          @user2 = FactoryBot.create(:user)
        sign_in @user1
      end
        it '正しく表示されているか' do
          expect(response.status).to eq 200
        end
        it 'レビューを編集できる' do
          expect(response).to redirect_to edit_product_review_path(@product1)
        end
        it 'レビューの更新ができる' do
          befor do
            pacth :update, product_review_path(@product)
          end
        end
        it 'レビューの削除ができる' do
          expext(click_buttun).to eq 'destroy'
        end
      end
    end
end



