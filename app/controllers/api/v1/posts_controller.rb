class Api::V1::PostsController < ApplicationController
    respond_to  :json
    def timeline
        user  = User.find(params[:user_id])
        posts = user.posts
        Post.where(id: Post.where.not(id: posts).select{|p| p.user_tagged == user}).each do |c|
            posts << c
        end
        render json: posts, status: :ok
    end
    def show_comments
        post = Post.find(params[:id])
        render json: post.comments, status: :ok
    end
    def create
        #post = Post.new(post_params)
	   post = Post.new 
	   post.text = params[:text]
	   post.image = params[:image]
	   post.user_id = params[:user_id].to_i
	   post.startup_id = params[:startup_id]
	   post.tagged_id = params[:tagged_id]
	     if(post.save)
            render json: post, status: :created
        else
            render json: post.errors.full_messages.first, status: 422
        end
	end     
end
