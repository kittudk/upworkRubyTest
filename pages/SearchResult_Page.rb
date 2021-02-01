require "selenium-webdriver"

class SearchResult_Page < CommonElements

# ====================== Elements =========================================================

      SEARCH_RESULTS = {:css => ".up-card-section"}
      SEARCH_RESULTS_FREELANCER_TITLE = {:css => ".freelancer-title"}
      SEARCH_RESULTS_FREELANCER_OVERVIEW = {:css => ".overview"}
      SEARCH_RESULTS_FREELANCER_NAME = {:css => ".identity-name"}

      SEARCH_RESULT_CLEAR_BTN = {:css => ".up-btn-clear"}
      SEARCH_RESULT_SLIDER_FREELANCER_NAME = {:css => "section.up-card-section [itemprop='name']"}
      SLIDER_FREELANCER_TITLE = {:css => ".up-card-section.py-30 h2[role='presentation']"}
      SLIDER_FREELANCER_OVERVIEW = {:css => "#up-lineclamp-1 .text-pre-line"}
      SLIDER_FREELANCER_OVERVIEW_MOREBTN = {:css => ".up-line-clamp [aria-controls='up-lineclamp-1']"}
      SLIDER_FREELANCER_SKILLS = {:css => "section.up-card-section.py-30 .skills .up-skill-badge"}

 # ========================================================================================
  @@search_result_information = []

  attr_reader :driver

  def initialize(driver)
      @driver = driver
  end

 # ================================== Actions/Methods ====================================

   def verify_if_searchresult_page_is_shown

    handle_captcha
    wait_until_element_displays(SEARCH_RESULT_CLEAR_BTN,15)
    puts "Search Result is shown"
    storeResultsInHash

   end

# Verify if keyword is present in each of the search result
   def verify_if_keyword_present_inresultPage(keyword)

       puts "Verifying if title contains "+keyword
       @@search_result_information.each do |hash|

         if hash['title'].include? keyword
           puts hash['name']+"'s title contains searched keyword "+keyword
         else
           puts hash['name']+"'s title' doesn't contain searched keyword "+keyword
         end
       end
     end

  # Click on random freelancer and verify details
  def click_on_randomfreelancer_and_verifyDetails(searchKeyword)
    click_on_freelancer_from_currentPage(3)
    verify_selected_freelancer_details(3,searchKeyword)

  end

  # Click on mentioned number of result in seach result page and verify details
  def click_on_freelancer_and_verifyDetails(n_result,searchKeyword)
    click_on_freelancer_from_currentPage(n_result)
    verify_selected_freelancer_details(n_result,searchKeyword)

  end

  def click_on_freelancer_from_currentPage(n_result)

      puts "Click on freelancer "+@@search_result_information[n_result]['name']
      driver.find_elements(SEARCH_RESULTS_FREELANCER_TITLE)[n_result].click
      wait_until_element_displays(SEARCH_RESULT_SLIDER_FREELANCER_NAME,15)
      wait_until_element_displays(SLIDER_FREELANCER_TITLE,15)

  end

  def storeResultsInHash

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
             @@search_result_information.push(searchData)
             index += 1
           end
     end

     # Verify recently clicked freelancer information
     def verify_selected_freelancer_details(nth_result,keyword)

           puts "Click on more button in previously opened slider"
           if(driver.find_elements(SLIDER_FREELANCER_OVERVIEW_MOREBTN).size > 0)
             driver.find_element(SLIDER_FREELANCER_OVERVIEW_MOREBTN).click
           end

           puts "Retrieve Freelancer name , title ,overview and skills"
           selected_freelancer_name = driver.find_element(SEARCH_RESULT_SLIDER_FREELANCER_NAME).text
           selected_freelancer_title = driver.find_element(SLIDER_FREELANCER_TITLE).text
           selected_freelancer_overview = driver.find_element(SLIDER_FREELANCER_OVERVIEW).text
           selected_freelancer_skills =  driver.find_elements(SLIDER_FREELANCER_SKILLS)

           selected_skill_arr = []

        # Fetch all the the skills from the slider information and store in an array

           selected_freelancer_skills.each do |skill|
            selected_skill_arr.push(skill.text)
           end

           puts "=============== Compare Name =========================="
           puts selected_freelancer_name+" , "+@@search_result_information[nth_result]['name']
          if (selected_freelancer_name.eql? @@search_result_information[nth_result]['name'])
             puts  selected_freelancer_name+"'s name matches with the stored data "
          end
           puts "======================================================="

           puts "=============== Compare Title =========================="
           puts selected_freelancer_title+" , "+@@search_result_information[nth_result]['title']

          if (selected_freelancer_title.eql? @@search_result_information[nth_result]['title'])
           puts  selected_freelancer_name+"'s title matches with the stored data "
          end
           puts "========================================================"


           puts "=============== Compare Skills =========================="
          if (selected_skill_arr.eql? @@search_result_information[nth_result]['skills'])
           puts  selected_freelancer_name+"'s skills matches with the stored data "
          end
           puts "========================================================="

       ## Verify keyword present in selected freelancer

         if selected_freelancer_name.include? keyword
           puts selected_freelancer_name+"'s title contains searched keyword "+keyword
         elsif selected_skill_arr.any? { |skill| skill.include?(keyword)}
           puts selected_freelancer_name+"'s Skills contains searched keyword "+keyword
         else
           puts selected_freelancer_name+"'s details doesn't contain keyword "+keyword
         end
     end
end
