class CreateDialogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dialogs, &:timestamps
  end
end
