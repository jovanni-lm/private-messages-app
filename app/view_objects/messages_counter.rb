class MessagesCounter < ViewObject
  attr_reader :unread_messages

  def html
    render_counter
  end

  def initialize(user)
    @unread_messages = Message.unread_messages(user)
  end

  private

  def members
    unread_messages.map { |message| message.user }
  end

  def unread_messages_count
    unread_messages.size
  end

  def incoming_messages?
    unread_messages_count > 0
  end

  def no_messages
    content_tag :li do
      content_tag :a do
        ['Messages ' + content_tag(:span, '0', class: 'badge')].reduce(&:+).html_safe
      end
    end
  end

  def users_input_list
    content_tag :li, class: 'dropdown' do
      content_tag(:a,role: 'button', class: 'dropdown-toggle', "data-toggle": 'dropdown', href: '#') do
        ["Messages #{unread_messages_count}", ul_list].reduce(&:+).html_safe
      end
    end
  end

  def users_list
    unread_messages.map { |message| { id: message.user.id, username: message.user.username } }
  end

  def ul_list
    content_tag(:ul, class: 'dropdown-menu') do
      users_list.uniq.map do |user|
        content_tag(:li) do
          content_tag(:a, "#{user[:username]} (#{users_list.count(user)})", href: user_path(user[:id]))
        end
      end.reduce(&:+)
    end
  end

  def render_counter
    if incoming_messages?
      users_input_list
    else
      no_messages
    end
  end
end
