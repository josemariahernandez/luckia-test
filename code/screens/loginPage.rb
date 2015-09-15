class LoginPage < BasePage
  def initialize(env)
    @env = env
    elements 'login_page'
  end

  def enter_credentials(user, pass)
    fill('user', user)
    fill('pass', pass)
    press('sign_in')
    UserHomePage.new(@platform, @env)
  end
end
