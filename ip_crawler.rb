require 'net/http'
require 'nokogiri'
# require 'pry'

class Crawler
  attr_reader :response, :result

  def initialize
    uri = URI('https://jlkenixiel.execute-api.ap-northeast-1.amazonaws.com/test/getallserverip')
    request = Net::HTTP::Get.new(uri)
    @response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    ip_list = Nokogiri.HTML(@response.body)
    result = ip_list.search('body').to_s.split('<br>')
  end
end

a = Crawler.new
head = ' Response: '
puts '=' * 20 + head + '=' * 20
a.response
puts a.result.class
puts a.result
puts '=' * (40 + head.size)
