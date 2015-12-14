class Api::V1::UsersController < ApplicationController
	respond_to  :json
	before_action :authenticate, except: [:test]
	def test
		render :json => {message: "ok"}, status: :ok		
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
end
