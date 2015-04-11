class Report < ActiveRecord::Base

  include KeywordCollector

  belongs_to :user

  def build_keywords_report(input_file)

    keywords = get_keywords input_file

    ActiveRecord::Base.transaction do

      # Make sure this report have id
      self.save

      keywords.each do |keyword|

        result = collect_data keyword

        keyword_obj = Keyword.new name: keyword, report: self
        keyword_obj.save

        search_result_obj = SearchResult.new keyword: keyword_obj
        search_result_obj.top_ads_count = result[:top_ads_count]
        search_result_obj.right_ads_count = result[:right_ads_count]
        search_result_obj.total_ads_count = result[:total_ads_count]
        search_result_obj.non_ads_count = result[:non_ads_count]
        search_result_obj.total_link = result[:link_count]
        search_result_obj.keyword_result = result[:total_search_result]
        search_result_obj.html_code = result[:html].force_encoding('iso-8859-1').encode('utf-8')

        search_result_obj.save

        result[:top_ads_urls].each do |url|
          SearchResultUrl.create url: url, url_type_id: UrlType::TOP_ADS_ID, search_result: search_result_obj
        end

        result[:right_ads_urls].each do |url|
          SearchResultUrl.create url: url, url_type_id: UrlType::RIGHT_ADS_ID, search_result: search_result_obj
        end

        result[:non_ads_urls].each do |url|
          SearchResultUrl.create url: url, url_type_id: UrlType::NON_ADS_ID, search_result: search_result_obj
        end

      end

    end

  end
end
