class SearchResult < ActiveRecord::Base
  belongs_to :keyword

  has_many :search_result_urls, dependent: :destroy
end
