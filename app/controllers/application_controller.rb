class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def authenticate
    begin

      if json_request?
        # The header can be any valid headers that send along with request that consume JSON
        token = request.headers['Authorization'].split(' ').last
        payload, header = AuthenticationHelper.valid?(token)

        @current_user = User.find_by(id: payload['user_id'])

      else
        @current_user ||= User.find_by(id: session[:user_id])
      end

    rescue

      respond_to do |format|
        format.html {redirect_to controller: :authentication}
        format.json {render json: { error: 'Authorization header not valid'}, status: :unauthorized}
      end

    end
  end

  def is_signed_in?

    if !@current_user
      respond_to do |format|
        format.html {redirect_to controller: :authentication}
        format.json {render json: {error: 'You are not signed in yet'}, status: :unauthorized}
      end
    end
    
  end

  def json_request?
    request.format.json?
  end
end
