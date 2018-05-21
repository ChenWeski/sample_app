module SessionsHelper

	def login(user)		
		session[:user_id] = user.id		
		
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])		

	end

	def logged_in?
		!current_user.nil?	
	end

	def logout
		
		session.delete(:user_id)
		@current_user = nil
		
	end

	def storing_url
		session[:forward_url] = request.original_url if request.get?
	end

	def forwarding_url(default)
		redirect_to (session[:forward_url] || default)
		session.delete(:forward_url)

	end

end
