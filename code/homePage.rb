class HomePage < BasePage
  def initialize(env)
    @env = env
    elements 'home_page'
  end

  def login
    press('enter')
    LoginPage.new(@env)
  end
end
