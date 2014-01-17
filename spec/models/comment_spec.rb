# run using the following command 'rspec spec/models/comment_spec.rb'
require "spec_helper"

describe Comment do
	# 
	it "has a valid factory" do
		FactoryGirl.create(:comment).should be_valid
	end
	
	# it should be valid withou an author because the author can be annonymous
	it "is valid without an author" do
		FactoryGirl.build(:comment, body: "Great stuff!", author: nil).should be_valid
	end	
end