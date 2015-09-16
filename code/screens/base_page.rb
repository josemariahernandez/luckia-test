require 'selenium-webdriver'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def waitUntil(element)
    wait = Selenium::WebDriver::Wait.new :timeout => 10
    wait.until { find_element(:id, @list_of_elements[element][@env]).displayed? }
  end

  def press(element)
    waitUntil(element)
    find_element(:id,@list_of_elements[element][@env]).click
  end

  def fill(element, text)
    press(element)
    find_element(:id, @list_of_elements[element][@env]).send_keys(text)
  end

  def exists?(element)
    waitUntil(element)
    exists { find_element(:id, @list_of_elements[element][@env]) }
  end

  def elements(file)
    @list_of_elements = YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../config/elements/#{file}.yml"))
  end
end
