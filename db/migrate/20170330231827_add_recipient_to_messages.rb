class AddRecipientToMessages < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :recipient, foreign_key: true
  end
end
