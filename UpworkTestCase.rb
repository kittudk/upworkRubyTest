    require 'selenium-webdriver'
    require './HomePage'

        BROWSER = "Firefox"
        KEYWORD = "QA"

        # Chrome browser instantiation
        if(BROWSER.downcase().eql? "chrome")
          @driver = Selenium::WebDriver.for :chrome
        # Firefox browser instantiation
        elsif (BROWSER.downcase().eql? "firefox")
          @driver = Selenium::WebDriver.for :firefox
        else
          puts "Only Chrome and Firefox browsers are supported"
        end


      if (!@driver.nil?)
          # maximize browser window
        @driver.manage.window.maximize
        # Load the mentioned URL
        @driver.get "https://www.upwork.com/"

        homepage = HomePage.new(@driver)
        homepage.searchKeyword(KEYWORD)
        homepage.storeResultsInHash()
        homepage.verify_if_keyword_present(KEYWORD)
        homepage.verify_freelancer_details(KEYWORD)
      end
