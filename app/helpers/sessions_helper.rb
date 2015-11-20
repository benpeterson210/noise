module SessionsHelper

	def log_inMethod(user)
		session[:user_id] = user.id
	end

	def current_user
	  if (user_id = session[:user_id])
      	@current_user ||= User.find_by(id: user_id)
      elsif (user_id = cookies.signed[:user_id])
      	user = User.find_by(id: user_id)
      	if user && user.authenticated?(cookies[:remember_token])
        	log_inMethod user
        	@current_user = user
      	end
      end
	end

	def logged_in?
		!current_user.nil?
	end

	def log_outMethod
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token	
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	#returns true if the given user is the current user
	def current_user?(user)
		user == current_user
	end

	#redirects to the stored location (or default location) - used for friendly forwarding
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	#stores the URL trying to be accessed
	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

end
