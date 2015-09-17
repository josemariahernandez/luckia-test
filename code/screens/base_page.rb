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

  def slideScreen(element, direction, times)
    el = find_element(:id, @list_of_elements[element]['id'][@env])

    horizontalMidpoint = ((el.size.width/2)+el.location.x)
    verticalMidpoint = ((el.size.height/2)+el.location.y)
    margin = 1
    right = el.location.x+el.size.width-margin
    left = el.location.x+margin
    up = el.location.y+margin
    down = el.location.y+el.size.height-margin
    duration = 2000

    times.times do
      if direction.eql?('RIGHT')
        swipe(start_x: left, start_y: verticalMidpoint,
              end_x: right, end_y: verticalMidpoint, duration: duration)
      elsif direction.eql?('LEFT')
        swipe(start_x: right, start_y: verticalMidpoint,
              end_x: left, end_y: verticalMidpoint, duration: duration)
      elsif direction.eql?('UP')
        swipe(start_x: horizontalMidpoint, start_y: down,
              end_x: horizontalMidpoint, end_y: up, duration: duration)
      elsif direction.eql?('DOWN')
        swipe(start_x: horizontalMidpoint, start_y: up,
              end_x: horizontalMidpoint, end_y: down, duration: duration)
      end
    end
  end

  def slideScreenToElement(elementToScroll, direction, elementToFind)
    el = find_element(:id, @list_of_elements[elementToScroll]['id'][@env])

    horizontalMidpoint = ((el.size.width/2)+el.location.x)
    verticalMidpoint = ((el.size.height/2)+el.location.y)
    margin = 1
    right = el.location.x+(el.size.width/2)-margin
    left = el.location.x+margin
    up = el.location.y+margin
    down = el.location.y+(el.size.height/2)-margin
    duration = 2000

    while(!exists { find_element(:id, @list_of_elements[elementToFind]['id'][@env]) })
      if direction.eql?('RIGHT')
        swipe(start_x: left, start_y: verticalMidpoint,
              end_x: right, end_y: verticalMidpoint, duration: duration)
      elsif direction.eql?('LEFT')
        swipe(start_x: right, start_y: verticalMidpoint,
              end_x: left, end_y: verticalMidpoint, duration: duration)
      elsif direction.eql?('UP')
        swipe(start_x: horizontalMidpoint, start_y: down,
              end_x: horizontalMidpoint, end_y: up, duration: duration)
      elsif direction.eql?('DOWN')
        swipe(start_x: horizontalMidpoint, start_y: up,
              end_x: horizontalMidpoint, end_y: down, duration: duration)
      end
    end
  end

  def elements(file)
    @list_of_elements = YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../config/elements/#{file}.yml"))
  end
end
