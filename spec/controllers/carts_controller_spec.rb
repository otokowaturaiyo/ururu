require 'rails_helper'
RSpec.describe CartsController, type: :controller do
	describe 'showページ' do
		context 'カートページが表示される' do
			before do
				get :show
			end
			it 'カートに商品がない場合、注意メッセージが表示される' do

			end
			

