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
<<<<<<< HEAD
  end

  def error_message_exists?
    fail 'Don\'t show error message' unless exists?('error_message')
=======
>>>>>>> bf7b5da6b6bc016460ee70aa950a4e78478bd3aa
  end
end
