module SessionsHelper
	attr_writer :current_user

	def log_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, remember_token)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by(remember_token: cookies[:remember_token])
	end
	def log_out(user)
		current_user.update_attribute(:remember_token, User.new_remember_token)
		cookies.delete :remember_token
		@current_user = nil
	end

	def logged_in?
		!current_user.nil?
	end

	def logged_in_user
		unless logged_in?	
			flash[:danger] = 'You must log in first.'
			redirect_to login_url 
		end
	end
 
end
