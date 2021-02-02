    require 'selenium-webdriver'
    require_relative './Constants'

    class Config

      #Define which browser to be used
      BROWSER = Constants::FIREFOX\

      @@driver = nil

      # Setup driver using the mentioned browser
      def setup(browser = BROWSER)
        # Chrome @browser instantiation
        if(browser.downcase().eql? "chrome")
          driver = Selenium::WebDriver.for :chrome
          # Firefox @browser instantiation
        elsif (browser.downcase().eql? "firefox")
          driver = Selenium::WebDriver.for :firefox
        else
          puts "Only Chrome and Firefox browsers are supported"
        end
        if (!driver.nil?)
          # maximize @browser window
          driver.manage.window.maximize
          # Load the mentioned URL
          driver.get "https://www.upwork.com/"
        end
        @@driver = driver
      end

      # Close browser and kill driver object
      def teardown()
        puts "Closing browser"
        @@driver.quit
      end

    end
