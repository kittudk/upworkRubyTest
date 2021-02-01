require "selenium-webdriver"

class CommonElements
  
  CAPTCHA = {:id => "px-captcha"}
  
  attr_reader :driver
  
    def initialize(driver)
        @driver = driver
    end
    
    def handle_captcha
        # Captcha
        if(driver.find_elements(CAPTCHA).size > 0)
          sleep 120
        end
    end
    
    def wait_until_element_displays(element, timeout=15)
         puts "Waiting for an element to show up"
         wait = Selenium::WebDriver::Wait.new(:timeout=> timeout)
         wait.until {driver.find_element(element).displayed? }
    end

end