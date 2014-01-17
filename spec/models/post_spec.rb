# run using the following command 'rspec spec/models/post_spec.rb'
require 'spec_helper'

describe Post do
	# Check if a factory has been created for posts
	it "has a valid factory" do
		FactoryGirl.create(:post).should be_valid
	end
	
	# Creating a post without the title is invalid
	it "is invalid without a title" do
		FactoryGirl.build(:post, title: nil, body: "the body", author: "1").should_not be_valid
	end
	
	# Creating a post without an body is invalid
	it "is invalid without a body" do
		FactoryGirl.build(:post, title: "a new blog post", body: nil, author: "1").should_not be_valid
	end
end