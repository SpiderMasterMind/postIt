class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :vote]
	before_action :require_user, except: [:show, :index]

  def index
		@posts = Post.all.sort_by { |post| post.total_votes }.reverse
  end

  def show
		@comment = Comment.new
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)	
		binding.pry
		@post.creator = current_user

		if @post.save
			flash[:notice] = "Post created"
			redirect_to posts_path
		else 
			render "new"
		end
	end

	def edit
	end

	def update

		if @post.update(post_params)
			flash[:notice] = "This post was updated"
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	def vote
		vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

		if vote.valid?
			flash[:notice] = "Your vote was counted."
		else
			flash[:error] = "You can only vote once!"
		end

		redirect_to :back
	end

	private

	def post_params
		params.require(:post).permit!
	end

	def set_post
		@post = Post.find(params[:id])
	end
end