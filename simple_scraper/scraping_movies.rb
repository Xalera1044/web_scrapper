require 'open-uri'
require 'nokogiri'
require 'csv'

def scrapping
  html = URI.open("https://www.imdb.com/search/title/?groups=top_100&sort=user_rating,desc")
  doc = Nokogiri::HTML(html)
  items_array = []

  doc.search(".lister-item-content").each do |element|
    name = element.css("h3.lister-item-header").text
    description = element.css("p.text-muted").text.strip
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
