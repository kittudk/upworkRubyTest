require "selenium-webdriver"
require_relative '../framework/UpworkTestCase'
require_relative '../pages/HomePage'
require_relative '../pages/Page'
require_relative '../pages/SearchResult_Page'

class HomePageSearchKeywordTest < Config

  KEYWORD = "QA"
  # setup driver
  Config.new.setup

  homepage = HomePage.new(@@driver)
  homepage.verify_If_homePage_isshown

  page = CommonElements.new(@@driver)
  page.click_on_switchsearch_btn
  page.select_hire_professional_agencies
  page.enter_search_keyword_into_searchbox(KEYWORD)

  searchPage = SearchResult_Page.new(@@driver)
  searchPage.verify_if_searchresult_page_is_shown
  searchPage.verify_if_keyword_present_inresultPage(KEYWORD)
  searchPage.click_on_randomfreelancer_and_verifyDetails(KEYWORD)

  #close browser
  Config.new.teardown

end
