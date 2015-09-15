class Pages
  def initialize(env)
    @env = env
  end

  def homePage
    HomePage.new(@env)
  end
end