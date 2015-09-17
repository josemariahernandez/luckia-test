class UserHomePage < HomePage
  def initialize(env)
    super(env)
    @env = env
    elements 'user_home_page'
  end

  def pageExists?(username)
    fail 'Not at user home page' unless exists?(:id, 'account_name')
  end

  def openProfileMenu
    press(:id, 'profile_menu')
  end
end
