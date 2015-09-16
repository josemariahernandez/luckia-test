class LoginPage < BasePage
  def initialize(env)
    super(env)
    @env = env
    elements 'login_page'
  end

  def enter_credentials(user, pass)
    fill('user', user)
    fill('pass', pass)
    press('sign_in')
    UserHomePage.new(@env)
  end
end
