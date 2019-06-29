require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  before do
    @user1 = FactoryBot.create(:user)
  end
    descript 'Userのデータが有効' do
     expect(@user1).to be_valid
    end
end

