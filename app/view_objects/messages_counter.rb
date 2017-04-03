class MessagesCounter < ViewObject
  attr_reader :user_new_messages

  def html
    render_counter
  end

  def initialize(user_new_messages, user)
    @user_new_messages = user_new_messages.new(user)
  end

  private

  def no_messages
    content_tag :a do
      ['Messages ' + content_tag(:span, '0', class: 'badge')].reduce(&:+).html_safe
    end
  end

  def users_input_list
    content_tag(:a,role: 'button', class: 'dropdown-toggle', "data-toggle": 'dropdown', href: '#') do
      ["Messages #{user_new_messages.unread_messages_count}", ul_list].reduce(&:+).html_safe
    end
  end

  def ul_list
    content_tag(:ul, class: 'dropdown-menu') do
      user_new_messages.users_list.uniq.map do |user|
        content_tag(:li) do
          content_tag(:a, "#{user[:username]} (#{user_new_messages.users_list.count(user)})", href: user_path(user[:id]))
        end
      end.reduce(&:+)
    end
  end

  def render_counter
    if user_new_messages.incoming_messages?
      users_input_list
    else
      no_messages
    end
  end
end
