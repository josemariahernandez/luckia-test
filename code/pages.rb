class Pages
  def initialize(env)
    @env = env
  end

  def homePage
    HomePage.new(@env)
  end

  def loginPage
    LoginPage.new(@env)
  end

  def userHomePage
    UserHomePage.new(@env)
  end

  def profileMenuPage
    ProfileMenuPage.new(@env)
  end

  def profilePage
    ProfilePage.new(@env)
  end
end
