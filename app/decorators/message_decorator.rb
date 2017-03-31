class MessageDecorator < Draper::Decorator
  delegate_all

  def show
    subject, align = object.is_user_author?(h.current_user) ? ['You', 'left'] : [object.user.username, 'right']

    h.content_tag :div, class: "text-#{align}" do
      [h.content_tag(:b, subject, class: 'visible-lg-block'),
      h.content_tag(:span, h.time_ago_in_words(object.created_at), class: 'text-muted'),
      h.content_tag(:p, object.body)].reduce(&:+).html_safe
    end
  end
end
