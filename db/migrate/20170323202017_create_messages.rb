class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.boolean :read
      t.references :dialog_id, foreign_key: true

      t.timestamps
    end
  end
end
