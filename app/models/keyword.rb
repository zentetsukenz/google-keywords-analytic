class Keyword < ActiveRecord::Base
  belongs_to :report

  has_one :search_result, dependent: :destroy
end
