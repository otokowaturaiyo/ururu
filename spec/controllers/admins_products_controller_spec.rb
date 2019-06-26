require 'rails_helper'
RSpec.describe Admins::ProductsController, type: :controller do
        before do
          @user1 = FactoryBot.create(:user)
          @user2 = FactoryBot.create(:user)
        end
        feature "ログインした状態で" do
    before do
      login(@user1)
    end
  end

#newアクション
    describe '新規商品追加ページ' do
      context "新規商品追加ページが正しく表示される" do
        before do
          get :new
        end
        it '正しく表示されていること' do
          expect(response.status).to eq 302
        end
      end
    end

#indexアクション
    describe '商品一覧ページ' do
      context "商品一覧ページが正しく表示させる" do
        before do
          get :index
        end
        it '正しく表示されていること' do
          expect(response.status).to eq 302
        end
      end
    end

#editアクション
    describe '商品編集ページ' do
      context "商品編集ページが正しく表示させる" do
        before do
          get :edit, params: {id: '1'}
        end
        it '正しく表示されていること' do
          expect(response.status).to eq 302
        end
      end
    end

#showアクション
    describe '商品詳細ページ' do
      context "商品詳細ページが正しく表示させる" do
        before do
          get :show, params: {id: '1'}
        end
        it '正しく表示されていること' do
          expect(response.status).to eq 302
        end
      end
    end
end