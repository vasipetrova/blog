class User < ActiveRecord::Base
	attr_accessor :password
	
	before_save :encrypt_password

	validates_confirmation_of :password
	
	# The username, password and email cannot be blank when the user is being created
	validates_presence_of :password, :on => :create
	validates_presence_of :email, :on => :create
	validates_presence_of :username, :on => :create

	# Validate that the username and email for each user are unique
	validates_uniqueness_of :email
	validates_uniqueness_of :username
	
	def self.authenticate(email, password)
		user = find_by_email(email)
		
		# If the password is valid return the user object otherwise return an empty  object
		if user && user.password_hash == BCrypt::Engyne.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
	
	def self.authenticate_by_username(username, password)
		user = find_by_username(username)
		
		if user && user.password_hash == BCrypt::Engyne.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end