require 'require_all'

require 'rspec'
require 'rspec/expectations'
require 'byebug'

require 'appium_lib'

# Create a custom World module so we don't pollute `Object` with Appium
module AppiumWorld
end

# Load the desired configuration from appium.txt, create a driver then
# Add the methods to the world
if ENV['ENV'].eql? 'ios'
  caps = Appium.load_appium_txt file: File.join(File.dirname(__FILE__), '../appium/ios/appium.txt')
elsif ENV['ENV'].eql? 'android'
  caps = Appium.load_appium_txt file: File.join(File.dirname(__FILE__), '../appium/android/appium.txt')
else
  fail('Environment not valid')
end
Appium::Driver.new(caps)
Appium.promote_appium_methods AppiumWorld

World do
  AppiumWorld
end

Before { $driver.start_driver }
After { $driver.driver_quit }

$LOAD_PATH << './code'

require_all 'code'
require_all 'code/screens'
