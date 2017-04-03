class UserNewMessages
  attr_reader :unread_messages

  def initialize(user)
    @unread_messages = Message.unread_messages(user)
  end

  def members
    unread_messages.map(&:user)
  end

  def unread_messages_count
    unread_messages.size
  end

  def incoming_messages?
    unread_messages_count > 0
  end

  def users_list
    unread_messages.map { |message| { id: message.user.id, username: message.user.username } }
  end
end
