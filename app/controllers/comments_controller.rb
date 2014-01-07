class CommentsController < ApplicationController
	 def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create!(params[:comment].permit(:post_id, :comment, :body))
		redirect_to @post
	end
end
