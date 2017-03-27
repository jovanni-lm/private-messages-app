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
    dialog = Dialog.find_or_create_by(sender: sender, recipient: recipient)
    @message = dialog.messages.create!(body: body)
  end
end
