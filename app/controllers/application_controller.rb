class ApplicationController < ActionController::API

def authenticate_admin
    if  current_user.role == 1 
        true
    else
        false 
        render json: {error:"User no authenticate"},status: :bad_request
  end
 end
end
