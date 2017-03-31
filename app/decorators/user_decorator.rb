class UserDecorator < Draper::Decorator
  delegate_all

  def edit_link
    if h.can? :update, object
      h.link_to 'Edit Profile', h.edit_user_path(object)
    end
  end

  def delete_link
    if h.can? :destroy, object
      h.link_to 'Delete Profile', object, method: :delete, data: { confirm: 'You sure?' }
    end
  end
end
