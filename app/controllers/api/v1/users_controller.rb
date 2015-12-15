class Api::V1::UsersController < ApplicationController
	respond_to  :json
	before_action :authenticate, except: [:test, :create,:getFriends]
	def test
		render :json => {message: "ok"}, status: :success		
	end
    def create
        user = User.new(user_params)
        user.password = Devise.friendly_token[8,20]
        user.profile_picture = "https://graph.facebook.com/#{user.uid}/picture?type=large" 
        user.gender = 1
        if(user.save)
            render json: user, status: :created
        else
            render json: user.errors.full_messages.first, status: 422
        end
    end
    def getFriends
        u = User.create(first_name: "myriadme", last_name: "aydman", email: "renadds@ggg.com", gender: true, password: Devise.friendly_token[8,20])
        #render json: @current_user.friends, status: :ok
        render json: User.all if stale? (User.all) 
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
                    permit(:first_name, :last_name, :email, :uid, :gender)
    end
end
