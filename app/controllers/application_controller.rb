class ApplicationController < ActionController::API

def authenticate_admin
    if  current_user.role == 1 
        true
    else
        false 
        render json: {error:"unauthenticated user, please make sure you are on an admin account"},status: :bad_request
  end
end
end
