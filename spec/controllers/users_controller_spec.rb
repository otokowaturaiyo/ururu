require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'マイページ' do
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされるか' do
        get :show, params: {id: '1'}
        expect(response).to redirect_to new_user_session_path
        expect(response.body).to include("flashの中身・・・")
      end
    end
    context 'ログインしている場合' do
      before do
        @user = User.create
      end
      context '自分のマイページに行く場合' do
        it "正しく表示されるか" do
          get :show, params: {id: '1'}
        end
      end
      context '他人のマイページに行く場合' do
        it "flashが表示されるか" do
          get :show, params: {id: '2'}
          expect(response.body).to include("権限がありません。")
        end
      end
    end
  end


end
