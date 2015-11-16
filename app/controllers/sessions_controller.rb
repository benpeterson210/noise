class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenicate(params[:session][:password])
		#log in and redirect to user's page
	redirect_to 'users#show'
  	else
	flash.now[:alert] = "Invalid email/password combination"
  	render 'new'
  	end
  end

  def destroy
  end
end
