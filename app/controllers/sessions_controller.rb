class SessionsController < ApplicationController
  def index
  end
  def new
  end
	def create
		user = User.validate_login(params[:session][:email], params[:session][:password])
		if user
			session[:user_id] = user.id
      $user_first_name = user.first_name
      $user_id=user.id
			redirect_to :controller => 'posts'
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
