class MessageMarkAsRead
  attr_reader :user, :message

  def initialize(message, user)
    @user    = user
    @message = message
  end

  def mark_as_read!
    message.read! if !message.read? && !message.is_user_author?(user)
  end
end
