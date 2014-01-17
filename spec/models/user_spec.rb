# run using the following command 'rspec spec/models/user_spec.rb'
require "spec_helper"

describe User do
	# check if a factory exists for the object user
	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end
	
	# Creating a user without the username is invalid
	it "is invalid without a username" do
		FactoryGirl.build(:user, username: nil).should_not be_valid
	end
	
	# Creating a user without an email is invalid
	it "is invalid without a email" do
		FactoryGirl.build(:user, username: "joesmo", email: nil, password: "123456").should_not be_valid
	end
		
	# Creating a user without a password should not validate
	it "is invalid without password" do
		FactoryGirl.build(:user, username: "tester", email: "tester@me.com", password: nil).should_not be_valid
	end
end