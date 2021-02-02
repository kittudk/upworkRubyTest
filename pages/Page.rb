require "selenium-webdriver"
require_relative '../utilities/driverUtilities'

# Define all the elements that are common through out all pages
class CommonElements < Utilities
  # ====================== Elements =========================================================

  NAVBAR_SEARCH_SWITCHBTN = {:css => "[data-cy='search-switch-button']"}
  NAVBAR_PROFESSIONAL_AGENCIES = {:css => "[data-cy='menuitem-freelancers-button']"}
  NAVBAR_SEARCH_TEXTBOX = {:name => 'q'}
  CAPTCHA = {:id => "px-captcha"}
  # ========================================================================================

  attr_reader :driver
  def initialize(driver)
    @driver = driver
  end
  # =============================== Actions/Methods ================================

  def handle_captcha
    # Captcha
    if(driver.find_elements(CAPTCHA).size > 0)
      sleep 120
    end
  end

  def click_on_switchsearch_btn
    puts "Click on switch button in search text box"
    search_switch_btn = driver.find_element(NAVBAR_SEARCH_SWITCHBTN)
    search_switch_btn.click
  end

  def select_hire_professional_agencies

    puts "Select Talent option from switch search dropdown"
    professional_agencies = driver.find_element(NAVBAR_PROFESSIONAL_AGENCIES)
    professional_agencies.click
    sleep 2

  end

  def enter_search_keyword_into_searchbox(keyword)

    puts "Enter "+keyword+" into searchbox"
    element = driver.find_element(NAVBAR_SEARCH_TEXTBOX)
    element.send_keys keyword
    element.submit

  end
end
