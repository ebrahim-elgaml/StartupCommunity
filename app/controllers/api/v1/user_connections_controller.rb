class Api::V1::UserConnectionsController < ApplicationController
	respond_to  :json
	before_action :set_user, only: [:index]
	def index
		user_connections = @current_user.friend_requests_connection
		render json: user_connections, status: :ok
	end
	def create
		user_connection = UserConnection.new(user_connection_params)
		if(user_connection.save)
			render json: user_connection, status: :created
		else
			render json: user_connection.errors.full_messages.first, status: 422
		end
    end
    def accept
    	user_connection = UserConnection.find(params[:id])
    	if user_connection.update(request_status: 2)
    		render json: user_connection, status: :created
    	else
    		render json: user_connection.errors.full_messages.first, status: 422
    	end
    end
    def reject
    	user_connection = UserConnection.find(params[:id])
    	if user_connection.update(request_status: 1)
    		render json: user_connection, status: :created
    	else
    		render json: user_connection.errors.full_messages.first, status: 422
    	end
    end
	protected 
		def set_user
			@current_user = User.find(params[:user_id])
		end
	private
    	def user_connection_params
        	params.require(:user_connection).
                    permit(:user_a_id, :user_b_id)
    	end
end
