class CreateDialogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dialogs do |t|
      t.references :sender_id, foreign_key: true
      t.references :recipient_id, foreign_key: true

      t.timestamps
    end
  end
end
