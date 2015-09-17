require 'selenium-webdriver'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def waitUntil(by, element)
    wait = Selenium::WebDriver::Wait.new :timeout => 10
    puts by
    puts element
    wait.until { find_element(by, @list_of_elements[element][by.to_s][@env]).displayed? }
  end

  def press(by, element)
    waitUntil(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).click
  end

  def fill(by, element, text)
    press(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).send_keys(text)
  end

  def exists?(by, element)
    waitUntil(by, element)
    exists { find_element(by, @list_of_elements[element][by.to_s][@env]) }
  end

  def getText(by, element)
    waitUntil(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).text
  end


  def elements(file)
    @list_of_elements = YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../config/elements/#{file}.yml"))
  end
end
