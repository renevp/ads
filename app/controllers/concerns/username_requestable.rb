module UsernameRequestable
  def request_username
    if current_user && current_user.username == 'facebook'
      redirect_to username_user_path(current_user)
    end
  end
end
