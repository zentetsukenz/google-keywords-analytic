class ReportController < ApplicationController

  before_action :authenticate
  before_action :is_signed_in?

  def index
    @reports = @current_user.reports.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json {render json: @reports}
    end
  end

  def show
    @report = @current_user.reports.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render json: @report}
    end
  end

  def show_html
    search_result = SearchResult.find params[:id]
    @raw_html = search_result.html_code

    respond_to do |format|
      format.html {render layout: false}
      format.json {render json: @raw_html}
    end
  end

  def delete
    report = Report.find params[:id]
    report.destroy

    respond_to do |format|
      format.html {redirect_to action: 'index'}
      format.json {render json: report}
    end
  end

end
