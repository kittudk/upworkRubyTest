require "selenium-webdriver"
require_relative '../framework/UpworkTestCase'
require_relative '../pages/HomePage'
require_relative '../pages/SearchResult_Page'

class HomePageSearchKeywordTest < Config

  KEYWORD = "QA"
  # setup driver
  Config.new.setup

  homepage = HomePage.new(@@driver)

  homepage.verify_If_homePage_isshown
  homepage.click_on_switchsearch_btn
  homepage.select_hire_professional_agencies
  homepage.enter_search_keyword_into_searchbox(KEYWORD)

  searchPage = SearchResult_Page.new(@@driver)

  searchPage.verify_if_searchresult_page_is_shown
  searchPage.verify_if_keyword_present_inresultPage(KEYWORD)
  searchPage.click_on_randomfreelancer_and_verifyDetails(KEYWORD)

  #close browser
  Config.new.teardown

end
