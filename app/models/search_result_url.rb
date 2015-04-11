class SearchResultUrl < ActiveRecord::Base
  belongs_to :search_result
  belongs_to :url_type
end
