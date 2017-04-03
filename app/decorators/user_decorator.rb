class UserDecorator < Draper::Decorator
  delegate_all

  def edit_link
    h.link_to 'Edit Profile', h.edit_user_path(object) if h.can? :update, object
  end

  def delete_link
    if h.can? :destroy, object
      h.link_to 'Delete Profile', object, method: :delete, data: { confirm: 'You sure?' }
    end
  end

  def new_link
    h.link_to 'Add New Profile', h.new_user_path if h.can? :create, object
  end

  def show_link
    h.link_to object.username, h.user_path(object) if h.can? :show, object
  end
end
