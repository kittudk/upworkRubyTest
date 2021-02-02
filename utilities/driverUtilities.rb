require "selenium-webdriver"

# define all utilities required throughout the framework
class Utilities

  # wait method with locator
  def wait_until_element_displays(element, timeout=15)
       puts "Waiting for an element to show up"
       wait = Selenium::WebDriver::Wait.new(:timeout=> timeout)
       wait.until {driver.find_element(element).displayed? }
  end

  # wait method with webelement
  def wait_until_webelement_displays(webelement, timeout=15)
       puts "Waiting for an Webelement to show up"
       wait = Selenium::WebDriver::Wait.new(:timeout=> timeout)
       wait.until {webelement.displayed?}
  end

end
