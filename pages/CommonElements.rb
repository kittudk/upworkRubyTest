require "selenium-webdriver"
require_relative '../utilities/driverUtilities'

class CommonElements < Utilities

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
end
