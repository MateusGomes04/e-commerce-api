class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def index
      render json: current_user
    end
  
    def create
        user = @User.find_by(email: params[:email])
    
        if user&.valid_password?(params[:password])
          payload = user.jwt_payload
          token = JWT.encode(payload,  Rails.application.secrets.secret_key_base)
          render json: { token: token }
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end

  def generate_jwt_token
    payload = self.jwt_payload
    JWT.encode(payload,  Rails.application.secrets.secret_key_base)
  end

  def jwt_payload
    {
      user_id: self.id,
      exp: 1.week.from_now.to_i
    }
  end
  