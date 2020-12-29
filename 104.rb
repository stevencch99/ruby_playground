require 'net/http'
require 'nokogiri'
require 'pry'

class Crawler
  attr_reader :response, :result

  def initialize
    # Add pages number at the end of search_query to get specific page's results
    search_query = 'https://www.104.com.tw/jobs/search/?keyword=rails&page='

    uri = URI('https://www.104.com.tw/jobs/search/?keyword=rails')
    request = Net::HTTP::Get.new(uri)
    @response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    company_list = Nokogiri.HTML(@response.body).xpath('//a').select { |node| /company/ =~ node.attributes['href'] }

    @result = company_list.each_with_index.reduce({}) do |hash, company|
      hash.merge!({
                    company[1] => [
                      company[0].attributes['title'].value.split[0][4..-1],
                      company[0].attributes['title'].value.split[1][5..-1],
                      company[0].attributes['href'].value
                    ]
                  })
    end
  end

  # How to get full data/next page
  # 1. try to get page count from page-select dom element, then fire rest of http requests.
  # page_select = doc.css("select[class~='page-select']")

  # 1.2. get page numbers from script tags
  # Nokogiri::HTML(response.body).xpath('//script').each { |node| p /\"totalPage\":[0-9]+/.match(node.children.first).to_s.split(':').last.to_i if node.children.any? && /totalPage/ =~ node.children.first }

  def total_pages
    page_node = Nokogiri::HTML(@response.body).xpath('//script/text()').select { |node| /totalPage/ =~ node }.first
    @total_pages_count = /\"totalPage\":\d+/.match(page_node).to_s.split(':')[-1].to_i
  end

  def total_count
    @result.count
  end

  # arr = []
  # Nokogiri.HTML(response.body).xpath('//a').each { |node| arr << node if /company/ =~ node.attributes['href'] }
  # p arr
  # p arr.count
end

a = Crawler.new

binding.pry
