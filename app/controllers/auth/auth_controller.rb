class Auth::AuthController < ApiController

    before_action :authenticate, only: [:me, :refresh, :logout]
  
    def signup
      alreadyUser = User.find_by_username(user_params[:username])
  
      if alreadyUser
        render json: { error: 'User already signup' }, status: 	:not_acceptable
      else
        user = User.new(user_params)
  
        if user.save
          render json: { msg: user.as_json(:except => :password) }, status: :ok
        else
          render json: { error: user.errors }, status: :unprocessable_entity
        end
      end
  
    end
  
    def login
      userInfo = user_params
      user = User.find_by_username(userInfo[:username])
  
      if user
        if user[:password] == userInfo[:password]
          token = Auth.issue({ id: user.id })
          respond_with_token(token)
        else
          render json: { error: "Wrong password"}, status: :unauthorized
        end
  
      else
        render json: { error: 'User not signup' }, status: 	:not_acceptable
      end
        
    end
  
    def logout
      
    end
  
    def refresh
      
    end
  
    def me
      render json: @current_user , status: :ok
    end
  
    private
      def user_params
        params.require(['username', 'password'])
        params.permit('username', 'password', 'email')
      end
  
      def respond_with_token(token)
        render json: { 
            access_token: token, 
            token_type: 'bearer', 
            expires_in: 3600 
          }, 
          status: :ok
      end
  end