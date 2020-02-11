require 'net/http'
require 'nokogiri'
# require 'pry'

uri = URI('https://www.104.com.tw/jobs/search/?keyword=rails')
request = Net::HTTP::Get.new(uri)
response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  http.request(request)
end

# arr = []
# Nokogiri.HTML(response.body).xpath('//a').each { |node| arr << node if /company/ =~ node.attributes['href'] }
# p arr
# p arr.count

company_list = Nokogiri.HTML(response.body).xpath('//a').select{ |node| /company/ =~ node.attributes['href'] }

res = company_list.each_with_index.reduce({}) do |hash, company|
  hash.merge!({
    company[1] => [
    company[0].attributes["title"].value.split[0][4..-1],
    company[0].attributes["title"].value.split[1][5..-1],
    company[0].attributes["href"].value
  ]})
end

# binding.pry
p res

# try to get page count from page-select dom element.
# page_select = doc.css("select[class~='page-select']")
