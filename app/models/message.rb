class Message < ApplicationRecord
  belongs_to :dialog
  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  def is_user_author?(account)
    user == account
  end

  def read?
    read
  end

  def read!
    update_attribute(:read, true)
  end

  scope :unread_messages, lambda { |account|
    where(read: false, recipient_id: account)
  }
end
