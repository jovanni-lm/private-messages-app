class CreateUserDialogs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_dialogs do |t|
      t.timestamps
      t.integer :user_id
      t.integer :dialog_id
    end
  end
end
