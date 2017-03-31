class MessageMarkAsRead
  attr_reader :user, :message

  def initialize(message, user)
    @user    = user
    @message = message
  end

  def mark_as_read!
    if !message.read? && !message.is_user_author?(user)
      message.read = true
      message.save
    end
  end
end
