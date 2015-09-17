class ProfileMenuPage < BasePage
  def initialize(env)
    super(env)
    @env = env
    elements 'profile_menu_page'
  end

  def goToProfile
    press(:id, 'perfil')
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> bf7b5da6b6bc016460ee70aa950a4e78478bd3aa
