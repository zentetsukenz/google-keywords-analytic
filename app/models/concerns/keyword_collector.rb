require 'nokogiri'
require 'open-uri'
require 'csv'

module KeywordCollector
  extend ActiveSupport::Concern

  def get_keywords(input_file)
    
    keywords = CSV.read input_file
    keywords.flatten!
    keywords.uniq!

    return false if keywords.empty? || keywords.length > 1000

    keywords

  end

  def collect_data(keyword)

    result = {
      top_ads_count: 0,
      right_ads_count: 0,
      total_ads_count: 0,
      top_ads_urls: [],
      right_ads_urls: [],
      non_ads_count: 0,
      non_ads_urls: [],
      link_count: 0,
      total_search_result: nil,
      html: nil
    }

    doc = Nokogiri::HTML(open(URI.escape("http://www.google.com/search?q=#{keyword}")))

    # The matching pattern logic need more time to inspect the Google search page result
    # So, I decided to keep it simple for now
    
    top_ads = doc.xpath("//div[@id='center_col']/div[@id='tads' or @id='taws']/ol/li")

    result[:top_ads_urls] = top_ads.collect {|e| e.css('cite').text.strip}.compact.reject {|e| e.empty?}
    result[:top_ads_count] = result[:top_ads_urls].length

    right_ads = doc.xpath("//div[@id='rhs_block' or @id='rhs']").css('ol li')

    result[:right_ads_urls] = right_ads.collect {|e| e.css('cite').text.strip}.compact.reject {|e| e.empty?}
    result[:right_ads_count] = result[:right_ads_urls].length

    result[:total_ads_count] = result[:top_ads_count] + result[:right_ads_count]

    non_ads = doc.css('div#center_col div#res li.g')

    result[:non_ads_urls] = non_ads.collect {|e| e.css('cite').text.strip}.compact.reject {|e| e.empty?}
    result[:non_ads_count] = result[:non_ads_urls].length

    result[:link_count] = doc.css('a').length
    result[:total_search_result] = doc.css('div#resultStats').text.strip
    result[:html] = doc.to_s

    result

  end

end