# Define a user 'fixture' essentially
FactoryGirl.define do 
	factory :user do |f| 
		f.username "jdoe" 
		f.email "jdoe@me.com"
		f.password "1234pass"
		f.password_confirmation "1234pass"
	end 
end