class AuthenticationController < ApplicationController

  layout 'authentication'

  def index
  end

  def new
  end

  def register

    if params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:error] = "Password doesn\'t match"
      
      return respond_to do |format|
        format.html {render :new}
        format.json {render json: { errors: "Password doesn\'t match" }, status: :bad_request}
      end

    end

    user = User.new(user_params)
    if user.save

      if json_request?
        token = AuthenticationHelper.issue_token({ user_id: user.id })
      else
        session[:user_id] = user.id
      end

      respond_to do |format|
        format.html {redirect_to :root}
        format.json {render json: { user: user.as_json(only: [:id, :username]), token: token }}
      end

    else
      flash.now[:error] = user.errors.full_messages.to_sentence
      respond_to do |format|
        format.html {render :new}
        format.json {render json: { errors: user.errors }}
      end
    end
  end

  def signin

    user = User.find_by(username: params[:user][:username].downcase)
    if user && user.authenticate(params[:user][:password])

      if json_request?
        token = AuthenticationHelper.issue_token({ user_id: user.id })
      else
        session[:user_id] = user.id
      end

      respond_to do |format|
        format.html {redirect_to :root}
        format.json {render json: { user: user.as_json(only: [:id, :username]), token: token }}
      end

    else
      flash.now[:error] = "Invalid username/password combination"
      respond_to do |format|
        format.html {render :index}
        format.json {render json: {error: "Invalid username/password combination"}, status: :unauthorized}
      end
    end

  end

  def signout

    # For any client that consume JSON could simply destroy their token upon signout, no need to send a request here.
    # But for a client that didn't consume JSON, its session need to be destroyed by sending request here
    
    session.delete(:user_id)
    @current_user = nil

    redirect_to action: :index
    
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
