  require "selenium-webdriver"

  class HomePage

    @@hash_arr = []

    HOMEPAGE_SEARCH_SWITCHBTN = {:xpath => "//button[@data-cy='search-switch-button']"}
    HOMEPAGE_PROFESSIONAL_AGENCIES = {:xpath => "//a[@data-cy='menuitem-freelancers-button']"}
    HOMEPAGE_SEARCH_TEXTBOX = {:name => 'q'}
    HOMEPAGE_SEARCHBTN = {:xpath => "//button[@aria-label='Search']/span[@icon-name='search']"}

    SEARCH_RESULTS = {:xpath => "//div[@class='up-card-section up-card-hover']"}
    SEARCH_RESULTS_FREELANCER_TITLE = {:xpath => "//p[contains(@class,'freelancer-title')]"}
    SEARCH_RESULTS_FREELANCER_OVERVIEW = {:xpath => "//p[contains(@class,'overview')]"}
    SEARCH_RESULTS_FREELANCER_NAME = {:xpath => "//div[contains(@class,'identity-name')]"}

    SEARCH_RESULT_CLEAR_BTN = {:xpath => "//button[contains(@class,'up-btn-clear')]"}
    SEARCH_RESULT_SLIDER_FREELANCER_NAME = {:xpath => "//h1[@itemprop='name']"}
    SLIDER_FREELANCER_TITLE = {:xpath => "//section[contains(@class,'up-card-section')]//h2[@role='presentation']"}
    SLIDER_FREELANCER_OVERVIEW = {:xpath => "//div[contains(@class,'up-line-clamp-expanded')]//span[contains(@class,'text-pre-line')]"}
    SLIDER_FREELANCER_OVERVIEW_MOREBTN = {:xpath => "//button[@class='up-btn-link']"}
    SLIDER_FREELANCER_SKILLS = {:xpath => "(//div[@class='skills'])[1]//*[contains(@class,'up-skill-badge')]"}

      attr_reader :driver

    def initialize(driver)
        @driver = driver
    end

    # Search in search textbox with a mentioned keyword
    def searchKeyword(keyword)

          handle_captcha()
          wait_until_element_displays(HOMEPAGE_SEARCH_SWITCHBTN,15)
          puts "Click on switch button in search text box"
          search_switch_btn = driver.find_element(HOMEPAGE_SEARCH_SWITCHBTN)
          search_switch_btn.click

          puts "Select Talent option from switch search dropdown"
          professional_agencies = driver.find_element(HOMEPAGE_PROFESSIONAL_AGENCIES)
          professional_agencies.click
          sleep 2
          puts "Enter "+keyword+" into searchbox"
          element = driver.find_element(HOMEPAGE_SEARCH_TEXTBOX)
          element.send_keys keyword
          element.submit
          handle_captcha()

  #        puts "Click on search button after entering search keyword"
  #        searchbtn =  driver.find_element(HOMEPAGE_SEARCHBTN)
  #        searchbtn.click

    end

    def storeResultsInHash

          wait_until_element_displays(SEARCH_RESULT_CLEAR_BTN,15)
          puts "Search Result is shown"
          results = driver.find_elements(SEARCH_RESULTS)

          puts "Storing result info data in Array of hashes"
          freelance_title = driver.find_elements(SEARCH_RESULTS_FREELANCER_TITLE)
          overview = driver.find_elements(SEARCH_RESULTS_FREELANCER_OVERVIEW)
          freelancer_name = driver.find_elements(SEARCH_RESULTS_FREELANCER_NAME)

          index=0
          until index >= results.size
            string_skill = Array.new
            searchData = Hash.new

          # Store Title in hash
            searchData['title']=freelance_title[index].text

          # Store overview in hash
            searchData['overview']=overview[index].text

          # Store freelancer name in hash
            searchData['name']=freelancer_name[index].text

          # Store all skills for a freelancer in an array
            skill_index = index+1
            skills = driver.find_elements(:xpath => "(//div[@class='up-skill-wrapper'])["+skill_index.to_s+"]/div[@class='up-skill-badge']")

            skills.each do |skill|
              string_skill.push(skill.text)
           end
            searchData['skills']= string_skill

          # Push all the hash data to the array
            @@hash_arr.push(searchData)
            index += 1
          end
    end

    # Verify random freelancer information
    def verify_freelancer_details(keyword)

      # Random number of result to be clicked and verified.
          index =4

      # Click on random freelancer
          puts "Click on freelancer "+@@hash_arr[index]['name']
          driver.find_elements(:xpath => "//p[contains(@class,'freelancer-title')]")[index].click
          wait_until_element_displays(SEARCH_RESULT_SLIDER_FREELANCER_NAME,15)
          wait_until_element_displays(SLIDER_FREELANCER_TITLE,15)

          puts "Click on more button in previously opened slider"
          driver.find_element(SLIDER_FREELANCER_OVERVIEW_MOREBTN).click

          puts "Retrieve Freelancer name , title ,overview and skills"
          selected_freelancer_name = driver.find_elements(SEARCH_RESULT_SLIDER_FREELANCER_NAME)[0].text
          selected_freelancer_title = driver.find_elements(SLIDER_FREELANCER_TITLE)[0].text
          selected_freelancer_overview = driver.find_elements(SLIDER_FREELANCER_OVERVIEW)[0].text
          selected_freelancer_skills =  driver.find_elements(SLIDER_FREELANCER_SKILLS)

          selected_skill_arr = []

       # Fetch all the the skills from the slider information and store in an array

          selected_freelancer_skills.each do |skill|
           selected_skill_arr.push(skill.text)
          end

          puts "=============== Compare Name =========================="
          puts selected_freelancer_name+" , "+@@hash_arr[index]['name']
         if (selected_freelancer_name.eql? @@hash_arr[index]['name'])
            puts  selected_freelancer_name+"'s name matches with the stored data "
         end
          puts "======================================================="

          puts "=============== Compare Title =========================="
          puts selected_freelancer_title+" , "+@@hash_arr[index]['title']

         if (selected_freelancer_title.eql? @@hash_arr[index]['title'])
          puts  selected_freelancer_name+"'s title matches with the stored data "
         end
          puts "========================================================"


          puts "=============== Compare Skills =========================="
         if (selected_skill_arr.eql? @@hash_arr[index]['skills'])
          puts  selected_freelancer_name+"'s skills matches with the stored data "
         end
          puts "========================================================="

      ## Any one attribute contains keyword

        if selected_freelancer_name.include? keyword
          puts selected_freelancer_name+"'s title contains searched keyword "+keyword
        elsif selected_skill_arr.any? { |skill| skill.include?(keyword)}
          puts selected_freelancer_name+"'s Skills contains searched keyword "+keyword
        else
          puts selected_freelancer_name+"'s details doesn't contain keyword "+keyword
        end
    end

    # Verify if keyword is present in each of the search result
    def verify_if_keyword_present(keyword)

      puts "Verifying if title contains "+keyword
      @@hash_arr.each do |hash|

        if hash['title'].include? keyword
          puts hash['name']+"'s title contains searched keyword "+keyword
        else
          puts hash['name']+"'s title' doesn't contain searched keyword "+keyword
        end
      end
    end

    def wait_until_element_displays(element, timeout=15)
        puts "Waiting for an element to show up"
        wait = Selenium::WebDriver::Wait.new(:timeout=> timeout)
        wait.until {driver.find_element(element).displayed? }
    end

    def handle_captcha
      # Captcha
      if(driver.find_elements(:id => 'px-captcha').size > 0)
        sleep 120
      end
    end

  end
