class UtilityController < ApplicationController

  before_action :authenticate
  before_action :is_signed_in?

  def index
  end

  def word_url_ads
  end

  def word_url_ads_report
    @keyword = params[:keyword]

    if @keyword.empty?

      flash.now[:error] = "No keyword specify"
      respond_to do |format|
        format.html {render :word_url_ads}
        format.json {render json: {err: 'No keyword specify'}, status: :bad_request}
      end

      return
    end

    @report = SearchResultUrl.word_url_ads(@keyword, @current_user)
  end

  def word_url
  end

  def word_url_report
    @keyword = params[:keyword]

    if @keyword.empty?

      flash.now[:error] = "No keyword specify"
      respond_to do |format|
        format.html {render :word_url}
        format.json {render json: {err: 'No keyword specify'}, status: :bad_request}
      end

      return
    end

    @report = SearchResultUrl.word_url(@keyword, @current_user)
  end

  def url_occurrence_ads
  end

  def url_occurrence_ads_report
    @url = params[:url]

    if @url.empty?

      flash.now[:error] = "No url specify"
      respond_to do |format|
        format.html {render :url_occurrence_ads}
        format.json {render json: {err: 'No url specify'}, status: :bad_request}
      end

      return
    end

    @report = SearchResultUrl.url_occurrence_ads(@url, @current_user)
  end

  def url_occurrence
  end

  def url_occurrence_report
    @url = params[:url]

    if @url.empty?

      flash.now[:error] = "No url specify"
      respond_to do |format|
        format.html {render :url_occurrence}
        format.json {render json: {err: 'No url specify'}, status: :bad_request}
      end

      return
    end

    @report = SearchResultUrl.url_occurrence(@url, @current_user)
  end

end
