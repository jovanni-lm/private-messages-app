class CreateDialogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dialogs do |t|
      t.integer :sender
      t.integer :recipient

      t.timestamps
    end
  end
end
