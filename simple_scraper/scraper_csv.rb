require 'open-uri'
require 'nokogiri'
require 'csv'

def scrapping
  html = URI.open("https://github.com/search?q=Ruby+web+scraping")
  doc = Nokogiri::HTML(html)
  items_array = []

  doc.search(".repo-list li").each do |element|
    name = element.css("a.v-align-middle").text
    description = element.css("p.mb-1").text.strip
    items_array << [name, description]
  end
  export(items_array)
end

def export(items_array)
  file_path = "data.csv"
  CSV.open(file_path, 'w') do |csv|
    csv << ["#", "name", "description"]
    items_array.each_with_index do |item, index|
      csv << [index + 1, item[0], item[1]]
    end
  end
end

scrapping
