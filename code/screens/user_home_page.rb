class UserHomePage < HomePage
  def initialize(env)
    super(env)
    @env = env
    elements 'user_home_page'
  end

  def pageExists?
    fail 'Don\'t be at user home page' unless exists?('account_name')
  end
end
