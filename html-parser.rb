require 'rest-client'
require 'nokogiri'
require 'open-uri'
require 'csv'

$csv = CSV.open("file.csv", "wb")
def getCarDetails page_no
  page_info = Nokogiri::HTML(open("https://www.olx.in/pune/vehicles/?search%5Bdescription%5D=1&page=#{page_no.to_s}"))
   count =   page_info.css('p.color-9.lheight14.margintop3.small').count
   i=0
  while(i<count)
     time_date = page_info.css('p.color-9.lheight14.margintop3.small')[i].text.strip
     car_details = page_info.css('h3.large a span')[i].text.strip
    if !time_date.include?('Jul')
      car_details = page_info.css('h3.large a span')[i].text.strip
      car_price = page_info.css('strong.c000')[i].text.strip
      $csv << ["#{car_details}", "#{car_price}"]
    end
    i+=1
  end
end


(1..5).each do |page_num|
  getCarDetails page_num
end
