class KeywordDataCollectController < ApplicationController

  before_action :authenticate
  before_action :is_signed_in?

  def index
  end

end
