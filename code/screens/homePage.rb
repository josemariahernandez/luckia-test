class HomePage < BasePage
  def initialize(env)
    super(@env)
    @env = env
    elements 'home_page'
  end

  def login
    press('enter')
    LoginPage.new(@env)
  end
end
