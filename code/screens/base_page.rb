require 'selenium-webdriver'

class BasePage
  def initialize(env)
    extend AppiumWorld
    @env = env
  end

  def press(by, element)
    slide_screen_to_element(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).click
  end

  def fill(by, element, text)
    slide_screen_to_element(by, element)

    # When we are working with native mobile apps tag_name is the equivalent to class at the web.
    # We have to perform the slide_screen and click instead than using #press because after click on the list-element the context/focus is set over the list itself and it is not possible to find the list-element again. 
    # TODO: make the class Spinner change for iOS setting it at launch time via Rakefile/env.rb.
    # TODO: this works for mobile apps. When working on web we should check that tag_name.eql? 'Select'. However we probably do not need to use the Select.new strategy since the find_element by :text strategy would most probably work as well for web.
    if(find_element(by, @list_of_elements[element][by.to_s][@env]).tag_name.eql? 'android.widget.Spinner')
      find_element(by, @list_of_elements[element][by.to_s][@env]).click
      find_element(:name, text).click
    elsif
      find_element(by, @list_of_elements[element][by.to_s][@env]).click
      find_element(by, @list_of_elements[element][by.to_s][@env]).clear
      find_element(by, @list_of_elements[element][by.to_s][@env]).send_keys(text)
    end
  end

  def exists?(by, element)
    # Sets the pre_check wait to the default implicit wait we set at the appium.txt
    exists(driver_attributes[:default_wait]) { find_element(by, @list_of_elements[element][by.to_s][@env]) }
  end

  def getText(by, element)
    slide_screen_to_element(by, element)
    find_element(by, @list_of_elements[element][by.to_s][@env]).text
  end

  def slide_screen(by, element, direction, times)
    scrollable = find_element(by, @list_of_elements[element][by.to_s][@env])

    points= get_swipe_points(scrollable)

    times.times do
      eval("#{direction}_full_swipe(points, 2000)")
    end
  end

  def slide_screen_to_element(byToScroll, elementToScroll, direction, byToFind, elementToFind)
    scrollable = find_element(byToScroll, @list_of_elements[elementToScroll][byToScroll.to_s][@env])

    points= get_swipe_points(scrollable)

    while(!exists?(byToFind, elementToFind))
      eval("#{direction}_half_swipe(points, 2000)")
    end
  end

  def slide_screen_to_element(by, elementToFind)
    scrollable = find_element(:class, 'android.widget.ScrollView')

    points= get_swipe_points(scrollable)

    while((!exists?(by, elementToFind)) and (!exists?(:xpath, 'bottom_limit')))
      up_half_swipe(points, 2000)
    end

    while((!exists?(by, elementToFind)) and (!exists?(:xpath, 'top_limit')))
      down_half_swipe(points, 2000)
    end
  end

  def fill_form(values)
    values.each do |key, value|
      fill(:id, key.to_s, value)
    end
  end

  def up_half_swipe(points, duration)
      swipe(start_x: points[:horizontal_mid_point], start_y: points[:bottom],
            end_x: points[:horizontal_mid_point], end_y: points[:vertical_mid_point], duration: duration)
  end 

  def down_half_swipe(points, duration)
      swipe(start_x: points[:horizontal_mid_point], start_y: points[:top],
            end_x: points[:horizontal_mid_point], end_y: points[:vertical_mid_point], duration: duration)
  end 

  def right_half_swipe(points, duration)
      swipe(start_x: points[:left], start_y: points[:vertical_mid_point],
              end_x: points[:horizontal_mid_point], end_y: points[:vertical_mid_point], duration: duration)
  end 

  def left_half_swipe(points, duration)
      swipe(start_x: points[:right], start_y: points[:vertical_mid_point],
              end_x: points[:horizontal_mid_point], end_y: points[:vertical_mid_point], duration: duration)
  end 

  def up_full_swipe(points, duration)
      swipe(start_x: points[:horizontal_mid_point], start_y: points[:bottom],
            end_x: points[:horizontal_mid_point], end_y: points[:top], duration: duration)
  end 

  def down_full_swipe(points, duration)
      swipe(start_x: points[:horizontal_mid_point], start_y: points[:top],
            end_x: points[:horizontal_mid_point], end_y: points[:bottom], duration: duration)
  end 

  def right_full_swipe(points, duration)
      swipe(start_x: points[:left], start_y: points[:vertical_mid_point],
              end_x: points[:right], end_y: points[:vertical_mid_point], duration: duration)
  end 

  def left_full_swipe(points, duration)
      swipe(start_x: points[:right], start_y: points[:vertical_mid_point],
              end_x: points[:left], end_y: points[:vertical_mid_point], duration: duration)
  end 
    
  def get_swipe_points(scrollable)
    points = Hash.new
    margin = 1
    points[:horizontal_mid_point] = ((scrollable.size.width/2) + scrollable.location.x)
    points[:vertical_mid_points] = ((scrollable.size.height/2) + scrollable.location.y)
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
