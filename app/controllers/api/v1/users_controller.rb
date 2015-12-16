class Api::V1::UsersController < ApplicationController
	respond_to  :json
	before_action :authenticate, except: [:test, :create, :show, :index]
    def index
        user = User.find(params[:id])
        users = User.where.not(id: user.friend_requests).where.not(id: user.friend_rejections).where.not(id: user.friend_accepted).where.not(id: user.request_friends).where.not(id: user.rejected_by).where.not(id: user.accepted_by)
        render json: users, status: :ok
    end
	def test
		render :json => {message: "ok"}, status: :ok		
	end
    def show
        render json: User.find(params[:id]), status: :ok
    end
    def create
        user = User.new(user_params)
        if(User.exists?(email: user.email))
            user = User.find_by(email: user.email)
            render json: user, status: :created
        else
            user.password = Devise.friendly_token[8,20]
            user.profile_picture = "https://graph.facebook.com/#{user.uid}/picture?type=large" 
            if(user.save)
                render json: user, status: :created
            else
                render json: user.errors.full_messages.first, status: 422
            end
        end
    end
	protected
      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
         @current_user = User.find_by(authentication_token: token)
        end
      end
      def render_unauthorized
        self.headers['WWW-Authenticate'] = 'Token realm="Application"'
        render :json => {result:"NOK", message: 'Bad credentials'}, status: 401
      end
   private
    def user_params
        params.require(:user).
                    permit(:first_name, :last_name, :email, :uid, :gender, :country)
    end
end
