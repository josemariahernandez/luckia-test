class ProfileMenuPage < BasePage
  def initialize(env)
    super(env)
    @env = env
    elements 'profile_menu_page'
  end

  def goToProfile
    press(:id, 'perfil')
  end
end
