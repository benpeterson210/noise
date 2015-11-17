class SessionsController < ApplicationController
  def new
  end

  def create
  	ben = User.find_by(email: params[:session][:email].downcase) #ben (change name to "user" is found in the sessions helper)
  	if ben && ben.authenticate(params[:session][:password])
		  log_inMethod ben
      redirect_to ben
  	else
	   flash.now[:alert] = "Invalid email/password combination"
  	 render 'new'
  	end
  end

  def destroy
  end
  
end
