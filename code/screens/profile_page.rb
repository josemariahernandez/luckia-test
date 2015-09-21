class ProfilePage < BasePage
  def initialize(env)
    super(env)
    @env = env
    elements 'profile_page'
  end
  
  def loadData(file)
    YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../features/support/#{file}.yml"))
  end

  def expectedUnmodifiableInformation()
    YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../features/support/unmodifiable_information.yml"))
  end

  def currentUnmodifiableInformation()
    current_unmodifiable_information = Hash.new
    current_unmodifiable_information['dni'] = getText(:id, 'dni')
    current_unmodifiable_information['user_name'] = getText(:id, 'user_name')
    current_unmodifiable_information['real_name'] = getText(:id, 'real_name')
    current_unmodifiable_information['1st_surname'] = getText(:id, '1st_surname')
    current_unmodifiable_information['2nd_surname'] = getText(:id, '2nd_surname')
    current_unmodifiable_information['birthday'] = getText(:id, 'birthday')
    current_unmodifiable_information['sex'] = getText(:id, 'sex')
    current_unmodifiable_information['nationality'] = getText(:id, 'nationality')
    current_unmodifiable_information['fiscal_address'] = getText(:id, 'fiscal_address')
    return current_unmodifiable_information
  end

  def enter_email(email)
    fill(:id, 'email', email)
    fill(:id, 'confirm_email', email)
    press(:id, 'modify_data')
  end

  def no_exists_message?
    fail 'Data can\'t be saved' if exists?(:id, 'message')
  end
end


