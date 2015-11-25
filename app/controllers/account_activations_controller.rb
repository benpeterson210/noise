class AccountActivationsController < ApplicationController
  
  def edit
  	user = User.find_by(email: params[:email])
  	if user && !user.activated? && user.authenticated?(:activation, params[:id])
  		user.activate #defined in User model
  		log_inMethod(user)
  		flash[:success] = "Account Activated"
  		redirect_to user
  	else
  		flash[:alert] = "Invalid activation link"
  		redirect_to root_url
  	end
  end

end
