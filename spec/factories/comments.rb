# Define a user 'fixture' essentially
FactoryGirl.define do 
	factory :comment do |f| 
		f.body "This blog post is awesome" 
		f.author "1"
	end 
end