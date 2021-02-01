require "selenium-webdriver"


class Utilities

  def wait_until_element_displays(element, timeout=15)
       puts "Waiting for an element to show up"
       wait = Selenium::WebDriver::Wait.new(:timeout=> timeout)
       wait.until {driver.find_element(element).displayed? }
  end

end
