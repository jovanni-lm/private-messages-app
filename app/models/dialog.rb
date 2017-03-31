class Dialog < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_dialogs
  has_many :users, through: :user_dialogs
end
