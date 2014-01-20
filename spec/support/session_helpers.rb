module SessionHelpers		
	
	# Create a helper function that signs in the user
	def sign_in_user
		# Use the user object we have already created

		# :controller => 'users', :action => :check_login  
		session[:user_id] = user.id
	end
end