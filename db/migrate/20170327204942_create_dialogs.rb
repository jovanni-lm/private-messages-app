class CreateDialogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dialogs do |t|
      t.timestamps
    end
  end
end
