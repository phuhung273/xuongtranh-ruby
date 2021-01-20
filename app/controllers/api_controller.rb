
class ApiController < ActionController::API

    def logged_in?
      !!current_user
    end
  
    def current_user
      if auth_present?
        user = User.select('username', 'email', 'name', 'avatar', 'roles')
                    .find(decoded_token['id'])
  
        if user
          @current_user ||= user #user or nil
        end
      end
    end
    
    def authenticate
      render json: { error: "Unauthorized"}, status: :unauthorized unless logged_in?
    end
  
    private
  
      def token
        auth_header.split(' ')[1]
      end
  
      def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
      end
  
      def decoded_token
        Auth.decode(token)
      end
  
      def auth_present?
        auth_header.split(' ')[0] == 'Bearer'
      end
      
  end