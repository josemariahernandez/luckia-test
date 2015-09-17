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
end
