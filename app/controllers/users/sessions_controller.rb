class Users::SessionsController < Devise::SessionsController
  respond_to :json


  before_action :authenticate_user, only: [:validate_token, :destroy]

  def create

    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        @token = jwt_session_create @user.id
        if @token
          @token = "Bearer #{@token}"
          return success_session_created
        else
          return error_token_create
        end
      else
        return  "error"
      end
    else
      return  "error"
    end
  end


  
  private



  def respond_with(resource, _opts = {})
    render json: {
      status: {code: 200, message: 'Logged in sucessfully.'},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  #attribute :created_date do |user|
   # user && user.created_at.strftime('%d/%m/%Y')
#end


end

