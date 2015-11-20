class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	# debugger  <--- add when you want to invoke byebug in the server prompt
  end	

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
      
    end


  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_inMethod @user #defined in sessions_helper.rb
  		flash[:success] = "Welcome to Noise"
  		redirect_to @user
	
	  else
		  render 'new'
	  end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def logged_in_user
      unless logged_in?
        flash[:alert] = "Please log in."
        redirect_to login_path
      end
    end

end

