class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	attr_accessor :password
	
	#before you save the password encrypt it BCrypt
	before_save :encrypt_password
	
	#validate that the password isn't blank
	validates_confirmation_of :password
	
	# The username, password and email cannot be blank when the user is being created
	validates_presence_of :password, :on => :create
	validates_presence_of :email, :on => :create
	validates_presence_of :username, :on => :create

	# Validate that the username and email for each user are unique
	validates_uniqueness_of :email
	validates_uniqueness_of :username
	
	# Authenticate a user with teh email and password using BCrypt	
	def self.authenticate_by_email(email, password)
		# Get the user record from the database using the email as a key
		user = User.find_by_email(email)
		
		# If the password is valid return the user object otherwise return an empty object
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
	
	# Authenticate a user with teh username and password using BCrypt
	def self.authenticate_by_username(username, password)
		# Get the user record from the database using the username as a key	
		user = find_by_username(username)
		
		# if the user is valid and the hashed passwords math return the user object
		#	otherwise return an empty object
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	
	# Hasing the password with salt using BCrypt
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end