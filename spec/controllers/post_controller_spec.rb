require "spec_helper"
require "post"

describe PostsController do
	let!(:user) { FactoryGirl.create(:user) }
	let!(:blog_post) { FactoryGirl.create(:post) }
				
	context 'success' do
		it "responds successfully to an HTTP 200 status" do
			get :index
			expect(response).to be_success
			expect(response.status).to eq(200)
		end	
		
		# check that the posts template is rentedred prolerly(index calls /posts/)
		it "renders the index tempate" do
			get :index
			expect(response).to render_template("index")
		end
		
		# check if the posts object is properly updated after adding new posts
		it "loads all of the posts into @posts" do
			# create 2 newe posts
			post1, post2 = Post.create!(title: "The new title", body: "A new blog post."), 
											Post.create!(title: "Another title", body: "Another blog post another day.")
			get :index
			
			# check to see if the 2 new posts are in the list of posts
			expect(assigns(:posts)).to include(post1, post2)
		end
		
		#check new post is created properly		
		it "should create new post" do
		 # Format the parameters for a json request
		 json = { :format => 'json', :post => { :title => "a new blog entry", 
		 																								:body => "today's weather hot hot hot!" } }																 

			# refence the login helper feature we created /features/feature_helper.rb
			sign_in_user 
			
			# create a new blog post. If its successfull the posts count should go up by 1
			expect {	
				post :create, json
			 }.to change(Post, :count).by(1)
		end
		
		#editing existing post should work
		it "should edit post body" do														 

			# refence the login helper feature we created /features/feature_helper.rb					
			sign_in_user
			
			# Update the body of post #1 with a new text. 
			put :update, { :id => blog_post.id, :post => { :body => "Edited the blog post body." } }
			
			# Verify that the body was updated properly by checking if it equals the updated string.
			assigns[:post].body.should == "Edited the blog post body." 
		end
	end	
end