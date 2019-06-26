require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'マイページ' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされるか' do
        get :show, params: {id: '1'}
        expect(response).to redirect_to new_user_session_path
        # expect(response.body).to include("flashの中身・・・")
      end
    end
    context 'ログインしている場合' do
      before do
        @user1 = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:user)
        sign_in @user1
      end
      context '自分のマイページに行rspec spec/controllersく場合' do
        before do
          get :show, params: {id: '1'}
        end
        it "正しく表示されるか" do
          expect(response.status).to eq 200
        end
      end
      context '他人のマイページに行く場合' do
        it "flashが表示されるか" do
          get :show, params: {id: '2'}
          expect(response).to redirect_to user_path(@user1)
          expect(flash[:warning]).to include("権限がありません。")
        end
      end
    end
  end

  describe 'ユーザー編集' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされるか' do
        get :edit, params: {id: '1'}
        expect(response).to redirect_to new_user_session_path
        # expect(response.body).to include("flashの中身・・・")
      end
    end
    context 'ログインしている場合' do
      before do
        @user1 = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:user)
        sign_in @user1
      end
      context '自分の編集に行く場合' do
        before do
          get :edit, params: {id: '1'}
        end
        it "正しく表示されるか" do
          expect(response.status).to eq 200
        end
      end
      context '他人のマイページに行く場合' do
        it "flashが表示されるか" do
          get :edit, params: {id: '2'}
          expect(response).to redirect_to user_path(@user1)
          expect(flash[:warning]).to include("権限がありません。")
        end
      end
    end
  end



end
