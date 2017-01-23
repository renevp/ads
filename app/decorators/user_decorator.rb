class UserDecorator
  def initialize(user)
    @user = user
  end

  def account_created_date
    @user.created_at.strftime('%B %d, %Y')
  end

  def method_missing(method_name, *args, &block)
    @user.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @user.respond_to?(method_name, include_private) || super
  end
end
