module SessionsHelper

	def log_inMethod(ben)
		session[:user_id] = ben.id
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

end
