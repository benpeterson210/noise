class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase) #ben (change name to "user" is found in the sessions helper)
  	if user && user.authenticate(params[:session][:password])
		  log_inMethod user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
  	else
	   flash.now[:alert] = "Invalid email/password combination"
  	 render 'new'
  	end
  end

  def destroy
    log_outMethod if logged_in?
    redirect_to root_url
  end

end
