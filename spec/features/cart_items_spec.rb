require 'rails_helper'

RSpec.feature "Cart_items", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  background do
  	@user1 = FactoryBot.create(:user)
  	@product1 = FactoryBot.create(:product)
  end

	feature 'showページ' do
		context 'カートページが表示される' do
			background do
				visit cart_path(@user1.id)
			end
			scenario 'リクエストは200 OKとなること' do
		       expect(response.status).to eq 200
		    end
		end
		# context 'カートに商品がある場合' do
		# 	background do
		# 		@cart_item = FactoryBot.create(:cart_item)
		# 	end
		# 	scenario '商品情報が正しく表示される' do
		# 		expect(page).to have_content @cart_item1.product.jacket_image_id
		# 		expect(page).to have_content @cart_item1.product.product_name
		# 		expect(page).to have_content @cart_item1.product.artist_id
		# 		expect(page).to have_content @cart_item1.product.label_id
		# 		expect(page).to have_content @cart_item1.product.genre_id
		# 		expect(page).to have_content @cart_item1.total_count
		# 		expect(page).to have_content @cart_item1.subtotal
		# 		expect(page).to have_content @cart_item1.total_price
		# 		end
		# 	end
		# end
		# context 'カートに追加した商品がもともとカートに無い時' do
		# 	background do

		# 	end
		# 	end
		# 	scenario '商品情報が新たに追加される' do

		# 	end
		# 	scenario 'リダイレクト先が正しい' do
		# 		expect(response).to redirect_to cart_path(@user1.id)
		# 	end
		# end
		# context 'カートに追加した商品がもともとカートにある時' do
		# 	background do

		# 	end
		# 	scenario 'すでにカートに入っている商品のカウントが増やされる' do

		# 	end
		# 	scenario 'リダイレクト先が正しい' do
		# 		expect(response).to redirect_to cart_path(@user1.id)
		# 	end
		# end
		# context 'カートから商品が削除された時' do
		# 	scenario '商品が削除されている' do
		# 		expect{delete :destroy, params: {id: cart_item}}.to change(cart_tem,:count).by(-1)
		# 	end
		# 	scenario 'リダイレクト先が正しい' do
		# 		delete :destroy, params: {id: item}
  #   			expect(response).to redirect_to cart_path(@user1.id)
		# 	end
	end
end

