class CommentsController < ApplicationController
	before_action :require_user

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user

		if @comment.save
			flash[:notice] = "Your comment was added"
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end

	end

	def vote
		@post = Post.find(params[:post_id])
		vote = Vote.create(voteable: Comment.find(params[:id]), creator: current_user, vote: params[:vote])

		if vote.valid?
			flash[:notice] = "Your vote was counted."
		else
			flash[:error] = "You can only vote once!"
		end

		redirect_to :back
	end


end
