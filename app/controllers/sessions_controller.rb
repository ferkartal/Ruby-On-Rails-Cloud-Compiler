class SessionsController < ApplicationController
  def index
  end
  def new
  end
  def create
    user = User.validate_login(params[:session][:email], params[:session][:password])
    if user
      session[:user_id] = user.id

      redirect_to posts_url(user.id)

    else
      flash[:status] = FALSE
      flash[:alert] = 'Invalid username and password!'
      redirect_to login_path
    end

  end
  def destroy
    session[:user_id] = nil
    redirect_to users_path
  end
end