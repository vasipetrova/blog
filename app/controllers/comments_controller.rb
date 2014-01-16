class CommentsController < ApplicationController	

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create!(comment_parameters)
		
		redirect_to @post
	end
	
	private
		def comment_parameters
			params[:comment].permit(:post_id, :comment, :body, :author)
		end
end
