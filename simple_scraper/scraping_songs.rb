require 'open-uri'
require 'nokogiri'
require 'csv'

def scrapping
  html = URI.open("https://www.rollingstone.com/music/music-lists/best-songs-of-all-time-1224767/")
  doc = Nokogiri::HTML(html)
  items_array = []

  doc.search(".c-gallery-vertical-album").each do |element|
    name = element.css("h2.c-gallery-vertical-album__title").text
    description = element.css("p.lrv-u-text-transform-uppercase u-letter-spacing-012").text.strip
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
