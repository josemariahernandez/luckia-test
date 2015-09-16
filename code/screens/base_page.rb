require 'appium_lib'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def press(element)
    find_element(:id,@list_of_elements[element][@env]).click
  end

  def elements(file)
    @list_of_elements = YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../config/elements/#{file}.yml"))
  end
end
