class HomePage < BasePage
  def initialize(env)
    super(env)
    @env = env
    elements 'home_page'
  end

  def goToLoginPage
    press(:id, 'enter')
  end
end
