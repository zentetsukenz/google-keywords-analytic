class UrlType < ActiveRecord::Base

  TOP_ADS_ID = 1
  RIGHT_ADS_ID = 2
  NON_ADS_ID = 3

  SEED_DATA = [{name: 'Top ads'}, {name: 'Right ads'}, {name: 'Non ads'}]

end
