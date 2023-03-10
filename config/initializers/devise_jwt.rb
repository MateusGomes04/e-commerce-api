# config/initializers/devise_jwt.rb
Devise.setup do |config|
    # outras configurações aqui
  
    config.jwt do |jwt|
      jwt.secret = Rails.application.secrets.secret_key_base
      # outras configurações do JWT aqui
      jwt.dispatch_requests = [
        ['POST', '/api/v1/auth/sign_in'],
        ['DELETE', '/api/v1/auth/sign_out'],
        ['POST', '/api/v1/auth/password'],
        ['PUT', '/api/v1/auth/password']
      ]
  
      jwt.revocation_requests = [
        ['DELETE', '/api/v1/auth/sign_out']
      ]
    end
  end
  