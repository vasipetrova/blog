class UsersController < ApplicationController
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(post_params)

		if @user.save
			flash[:notice] = "Your registration is successful!"
			flash[:color] = "valid"
			redirect_to :action => :index
		else
			flash[:notice] = "Form is invalid!"
			flash[:color] = "invalid"
		end
	end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:user).permit(:email, :username, :password, :password_confirmation)
    end	
end