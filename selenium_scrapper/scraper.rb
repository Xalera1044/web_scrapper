require 'selenium-webdriver'
require 'csv'

options = Selenium::WebDriver::Chrome::Options.new
options.headless!

driver = Selenium::WebDriver.for(:chrome, capabilities: [options])
driver.get "https://github.com/search?q=ruby+web+scraping&ref=simplesearch"

driver.find_elements(css: ".repo-list li").each do |e|
  name = e.find_element(css: 'a.v-align-middle').text
  description = e.find_element(css: 'p.mb-1').text.strip

  # export(items_array)
end

# def export(items_array)
#   file_path = "data.csv"
#   Csv.open(file_path, 'w') do |csv|
#     csv << ["#", "name", "description"]
#     items_array.each_with_index do |item, index|
#       csv << [index + 1, item[0], item[1]]
#     end
#   end
# end

driver.quit
