  require "selenium-webdriver"
  require_relative "./Page"


  class HomePage < CommonElements

    # ====================== Elements =========================================================
    HOMEPAGE_GETSTARTED_BTN = {:css => "[data-qa='cta']"}
    HOMEPAGE_HIRETALENT_BTN = {:css => "[data-qa='hire-talent-btn']"}

    # ========================================================================================
    attr_reader :driver

    def initialize(driver)
      @driver = driver
    end

    # ================================== Actions/Methods ====================================

    def verify_If_homePage_isshown
      handle_captcha()
      title = driver.title
      puts title
      if driver.find_elements(HOMEPAGE_GETSTARTED_BTN).size > 0
        wait_until_element_displays(HOMEPAGE_GETSTARTED_BTN,15)
        puts "Home/Landing page is loaded"
      elsif driver.find_elements(HOMEPAGE_HIRETALENT_BTN).size > 0
        wait_until_element_displays(HOMEPAGE_HIRETALENT_BTN,15)
        puts "Home/Landing page is loaded"
      end
    end
  end
