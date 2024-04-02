class AddTelegramIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :telegram_id, :integer
  end
end
