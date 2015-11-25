class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	# debugger  <--- add when you want to invoke byebug in the server prompt
  end	

  def edit
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def update
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
      @user.send_activation_email
      #log_inMethod @user removed once we added mailer #defined in sessions_helper.rb
  		flash[:primary] = "Please check your email to activate account"
  		redirect_to root_url
	
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
            store_location
            flash[:alert] = "Please log in."
            redirect_to login_path
          end
        end

        def correct_user
          @user = User.find(params[:id])
          redirect_to(root_url) unless current_user?(@user)
        end

        def admin_user
          redirect_to(root_url) unless current_user.admin?
        end
end

