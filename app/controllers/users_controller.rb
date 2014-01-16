class UsersController < ApplicationController
	def new
		@user = User.new
	end
	
	#	Creat a new user
	def create
		@user = User.new(post_params)

		if @user.save
			flash[:notice] = "Your registration is successful!"
			flash[:color] = "valid"
			redirect_to :action => "login"
		else
			flash[:notice] = "Form is invalid!"
			flash[:color] = "invalid"
		end
	end

	#	Login
	def login
	
	end
	
	# Authenticate the user
	def check_login
		# Get the username and password parameters from the form parameters
		# and verify the username/email and password match
		username = params[:user][:username]
		password = params[:user][:password]
		
		# if the username field contains an @ symbol then verify by email
		# otherwise verify by username
		if username.index('@')
			user = User.authenticate_by_email(username, password)
		else
			user = User.authenticate_by_username(username, password)
		end

		# if the user has been varified, set the session variables and 
		# redirect the user to the account profile page
		if user
			session[:user_id] = user.id
			redirect_to :account_profile
		#	if the user or password don't match display an error message on the page
		else
			flash[:error] = "Invalid username or password!"
			flash[:color] = "invalid"			
			render :login
		end
	end
	
	# Logout the current user
	def logout
		current_user = nil
		session[:user_id] = nil
		redirect_to root_url, :notice => "Logged out!"
	end
	
	# Get the user accoutn informaiton
	def account_profile
		if session[:user_id] != nil
			@sesssionName = User.find(session[:user_id]).username
		else
			@sesssionName = "Guest"
		end
	
		if params[:id]
			@my_posts = Post.find(:all, :conditions => {:author => params[:id]})
		else
			@my_posts = Post.find(:all, :conditions => {:author => current_user.id})
		end
	end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end	
end