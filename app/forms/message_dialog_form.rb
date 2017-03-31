class MessageDialogForm
  include ActiveModel::Model
  include Virtus.model

  attribute :body, String
  attribute :sender, Integer
  attribute :recipient, Integer

  attr_accessor :message

  validates :body, :sender, :recipient, presence: true

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    sender_user, recipient_user = User.find(sender), User.find(recipient)

    dialog = ([sender_user.dialogs, recipient_user.dialogs].inject(:&)).first

    dialog = Dialog.create!(users: [sender_user, recipient_user]) unless dialog.present?

    dialog.messages.create!(body: body, user: sender_user, recipient: recipient_user)
  end
end
