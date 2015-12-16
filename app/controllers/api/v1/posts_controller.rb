class Api::V1::PostsController < ApplicationController
    respond_to  :json
    def timeline
        posts=Post.where(:user_id => 1)
        render json: posts
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
