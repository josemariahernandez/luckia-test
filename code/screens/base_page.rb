require 'selenium-webdriver'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def press(by, element)
    slideScreenToElement(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).click
  end

  def fill(by, element, text)
    press(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).clear
    find_element(by, @list_of_elements[element][by.to_s][@env]).send_keys(text)
  end

  def exists?(by, element)
    # Sets the pre_check wait to the default implicit wait we set at the appium.txt
    exists(driver_attributes[:default_wait]) { find_element(by, @list_of_elements[element][by.to_s][@env]) }
  end

  def getText(by, element)
    slideScreenToElement(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).text
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

    while(!exists { find_element(byToFind, @list_of_elements[elementToFind][byToFind][@env]) })
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
            end_x: points[:horizontalMidpoint], end_y: points[:verticalMidPoint], duration: 2000)
    end

    while(!exists?(by, elementToFind) and (!exists?(:xpath, 'top_limit')))
      swipe(start_x: points[:horizontalMidpoint], start_y: points[:top],
            end_x: points[:horizontalMidpoint], end_y: points[:verticalMidPoint], duration: 2000)
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
