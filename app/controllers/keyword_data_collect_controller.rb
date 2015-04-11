class KeywordDataCollectController < ApplicationController

  before_action :authenticate
  before_action :is_signed_in?

  def index
  end

  def upload

    # report = Report.new user: @current_user, name: "#{params[:file].original_filename} - #{DateTime.now.strftime('%Y-%m-%d %H:%M:%S')}"
    report = Report.new user: @current_user, name: "#{params[:file].original_filename}"
    report.build_keywords_report params[:file].tempfile

    render json: {report: report}, status: :ok
  end

end
