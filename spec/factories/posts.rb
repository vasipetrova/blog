# Define a post 'fixture' essentially
FactoryGirl.define do 
	factory :post do |f| 
		f.title "A new blog post" 
		f.body "The blog post body"
		f.author "1"
	end 
end