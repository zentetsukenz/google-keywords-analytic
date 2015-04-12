class SearchResultUrl < ActiveRecord::Base
  belongs_to :search_result
  belongs_to :url_type

  def self.word_url_ads(keyword, current_user)

    self.joins({
      search_result: {
        keyword: {
          report: :user
        }
      }
      }).where({users: {id: current_user.id}}).where(url_type_id: [UrlType::TOP_ADS_ID, UrlType::RIGHT_ADS_ID]).where('search_result_urls.url like ?', "%#{keyword}%")

  end

  def self.word_url(keyword, current_user)

    self.joins({
      search_result: {
        keyword: {
          report: :user
        }
      }
      }).where({users: {id: current_user.id}}).where(url_type_id: UrlType::NON_ADS_ID).where('search_result_urls.url like ?', "%#{keyword}%")

  end

  def self.url_occurrence_ads(url, current_user)

    self.joins({
      search_result: {
        keyword: {
          report: :user
        }
      }
      }).where({users: {id: current_user.id}}).where(url_type_id: [UrlType::TOP_ADS_ID, UrlType::RIGHT_ADS_ID]).where('search_result_urls.url = ?', url)

  end

  def self.url_occurrence(url, current_user)

    self.joins({
      search_result: {
        keyword: {
          report: :user
        }
      }
      }).where({users: {id: current_user.id}}).where(url_type_id: UrlType::NON_ADS_ID).where('search_result_urls.url = ?', url)

  end
end
