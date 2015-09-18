class LoginPage < BasePage
  def initialize(env)
    super(env)
    @env = env
    elements 'login_page'
  end

  def enter_credentials(user, pass)
    fill(:id, 'user', user)
    fill(:id, 'pass', pass)
    press(:id, 'sign_in')
  end

  def error_message_exists?
    fail 'Don\'t show error message' unless exists?(:id, 'error_message')
  end
end
