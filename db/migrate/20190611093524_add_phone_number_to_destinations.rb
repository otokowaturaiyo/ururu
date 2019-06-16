class AddPhoneNumberToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :phone_number, :string
  end
end
