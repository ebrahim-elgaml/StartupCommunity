class Api::V1::CommentsController < ApplicationController
	respond_to  :json
	def create
		comment = Comment.new(comment_params)
		if(comment.save)
			render json: comment, status: :created
		else
			render json: comment.errors.full_messages.first, status: 422
		end
    end
    private
    	def comment_params
        	params.require(:comment).
                    permit(:text, :post_id, :user_id)
    	end
end
