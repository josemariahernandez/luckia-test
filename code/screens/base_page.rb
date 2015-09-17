require 'selenium-webdriver'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def waitUntil(element)
    wait = Selenium::WebDriver::Wait.new :timeout => 10
    wait.until { find_element(:id, @list_of_elements[element]['id'][@env]).displayed? }
  end

  def press(element)
    waitUntil(element)
    find_element(:id,@list_of_elements[element]['id'][@env]).click
  end

  def fill(element, text)
    press(element)
    find_element(:id, @list_of_elements[element]['id'][@env]).send_keys(text)
  end

  def exists?(element)
    waitUntil(element)
    exists { find_element(:id, @list_of_elements[element]['id'][@env]) }
  end

  def slideScreen(element, direction, times)
    el = find_element(:class, @list_of_elements[element]['id'][@env])

    horizontalMidpoint = ((el.size.width/2)+el.location.x)
    verticalMidpoint = ((el.size.height/2)+el.location.y)
    margin = 1
    right = el.location.x+el.size.width-margin
    left = el.location.x+margin
    up = el.location.y+margin
    down = el.location.y+el.size.height-margin
    duration = 2000

    times.times do
      if direction.eql?("RIGHT")
        swipe(start_x: left, start_y: verticalMidpoint, end_x: right, end_y: verticalMidpoint, duration: duration)
      elsif direction.eql?("LEFT")
        swipe(start_x: right, start_y: verticalMidpoint, end_x: left, end_y: verticalMidpoint, duration: duration)
      elsif direction.eql?("UP")
        swipe(start_x: horizontalMidpoint, start_y: down, end_x: horizontalMidpoint, end_y: up, duration: duration)
      elsif direction.eql?("DOWN")
        swipe(start_x: horizontalMidpoint, start_y: up, end_x: horizontalMidpoint, end_y: down, duration: duration)
      end
    end
  end

  def elements(file)
    @list_of_elements = YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../config/elements/#{file}.yml"))
  end
end
