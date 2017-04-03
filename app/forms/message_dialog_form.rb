class MessageDialogForm
  include ActiveModel::Model
  include Virtus.model

  attribute :body, String
  attribute :sender, Integer
  attribute :recipient, Integer

  attr_accessor :message

  validates :body, :sender, :recipient, presence: true

  def save
    return false unless valid?
    persist!
  end

  private

  def persist!
    sender_user = User.find(sender)
    recipient_user = User.find(recipient)

    dialog = [sender_user.dialogs, recipient_user.dialogs].inject(:&).first

    dialog = Dialog.create!(users: [sender_user, recipient_user]) unless dialog.present?

    dialog.messages.create!(body: body, user: sender_user, recipient: recipient_user)
  end
end
