  require "selenium-webdriver"
  require_relative "./CommonElements"

  class HomePage < CommonElements

    HOMEPAGE_SEARCH_SWITCHBTN = {:css => "[data-cy='search-switch-button']"}
    HOMEPAGE_PROFESSIONAL_AGENCIES = {:css => "[data-cy='menuitem-freelancers-button']"}
    HOMEPAGE_SEARCH_TEXTBOX = {:name => 'q'}

    attr_reader :driver

    def initialize(driver)
        @driver = driver
    end

    def verify_If_homePage_isshown
      handle_captcha()
      wait_until_element_displays(HOMEPAGE_SEARCH_SWITCHBTN,15)
      title = driver.title
      puts title
      puts "Home page is loaded"
    end

    def click_on_switchsearch_btn
      puts "Click on switch button in search text box"
      search_switch_btn = driver.find_element(HOMEPAGE_SEARCH_SWITCHBTN)
      search_switch_btn.click
    end

    def select_hire_professional_agencies

      puts "Select Talent option from switch search dropdown"
      professional_agencies = driver.find_element(HOMEPAGE_PROFESSIONAL_AGENCIES)
      professional_agencies.click
      sleep 2

    end

    def enter_search_keyword_into_searchbox(keyword)

      puts "Enter "+keyword+" into searchbox"
      element = driver.find_element(HOMEPAGE_SEARCH_TEXTBOX)
      element.send_keys keyword
      element.submit

    end

  end
