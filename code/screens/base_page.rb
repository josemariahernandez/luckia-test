require 'selenium-webdriver'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def waitUntil(by, element)
    wait = Selenium::WebDriver::Wait.new :timeout => 10
    begin
      wait.until { find_element(by, @list_of_elements[element][by.to_s][@env]).displayed? }
    rescue
      return false
    end
    true
  end

  def press(by, element)
    waitUntil(by, element)
    slideScreenToElement(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).click
  end

  def fill(by, element, text)
    press(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).clear
    find_element(by, @list_of_elements[element][by.to_s][@env]).send_keys(text)
  end

  def exists?(by, element)
    waitUntil(by, element)
  end

  def getText(by, element)
    waitUntil(by, element)
    slideScreenToElement(by, element)
    find_Element(by, @list_of_elements[element][by.to_s][@env]).text
  end

  def slideScreen(by, element, direction, times)
    el = find_element(by, @list_of_elements[element][by.to_s][@env])

    points= getSwipePoints(scrollable)

    times.times do
      if direction.eql?('RIGHT')
        swipe(start_x: points[:left], start_y: points[:verticalMidpoint],
              end_x: points[:right], end_y: points[:verticalMidpoint], duration: 2000)
      elsif direction.eql?('LEFT')
        swipe(start_x: points[:right], start_y: points[:verticalMidpoint],
              end_x: points[:left], end_y: points[:verticalMidpoint], duration: 2000)
      elsif direction.eql?('UP')
        swipe(start_x: points[:horizontalMidpoint], start_y: points[:bottom],
              end_x: points[:horizontalMidpoint], end_y: points[:top], duration: 2000)
      elsif direction.eql?('DOWN')
        swipe(start_x: points[:horizontalMidpoint], start_y: points[:top],
              end_x: points[:horizontalMidpoint], end_y: points[:bottom], duration: 2000)
      end
    end
  end

  def slideScreenToElement(byToScroll, elementToScroll, direction, byToFind, elementToFind)
    el = find_element(byToScroll, @list_of_elements[elementToScroll][byToScroll.to_s][@env])

    points= getSwipePoints(scrollable)

    while(!exists { find_element(byToFind, @list_of_elements[elementToFind][byToFind.to_s][@env]) })
      if direction.eql?('RIGHT')
        swipe(start_x: points[:left], start_y: points[:verticalMidpoint],
              end_x: points[:right], end_y: points[:verticalMidpoint], duration: 2000)
      elsif direction.eql?('LEFT')
        swipe(start_x: points[:right], start_y: points[:verticalMidpoint],
              end_x: points[:left], end_y: points[:verticalMidpoint], duration: 2000)
      elsif direction.eql?('UP')
        swipe(start_x: points[:horizontalMidpoint], start_y: points[:bottom],
              end_x: points[:horizontalMidpoint], end_y: points[:top], duration: 2000)
      elsif direction.eql?('DOWN')
        swipe(start_x: points[:horizontalMidpoint], start_y: points[:top],
              end_x: points[:horizontalMidpoint], end_y: points[:bottom], duration: 2000)
      end
    end
  end

  def slideScreenToElement(by, elementToFind)
    scrollable = find_element(:class, 'android.widget.ScrollView')

    points= getSwipePoints(scrollable)

    while(!exists?(by, elementToFind) and (!exists?(:xpath, 'bottom_limit')))
      swipe(start_x: points[:horizontalMidpoint], start_y: points[:bottom],
            end_x: points[:horizontalMidpoint], end_y: points[:verticalMidPoint], duration: 1000)
    end

    while(!exists?(by, elementToFind) and (!exists?(:xpath, 'top_limit')))
      swipe(start_x: points[:horizontalMidpoint], start_y: points[:top],
            end_x: points[:horizontalMidpoint], end_y: points[:verticalMidPoint], duration: 1000)
    end 
  end

  def getSwipePoints(scrollable)
    points = Hash.new
    margin = 1
    points[:horizontalMidPoint] = ((scrollable.size.width/2) + scrollable.location.x)
    points[:verticalMidPoints] = ((scrollable.size.height/2) + scrollable.location.y)
    points[:right] = scrollable.location.x + scrollable.size.width - margin
    points[:left] = scrollable.location.x + margin
    points[:top] = scrollable.location.y + margin
    points[:bottom] = scrollable.location.y + scrollable.size.height - margin
    return points
  end

  def elements(file)
    @list_of_elements = YAML.load(File.read("#{File.expand_path File.dirname(__FILE__)}/../../config/elements/#{file}.yml"))
  end
end
