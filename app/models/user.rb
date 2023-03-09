class User < ApplicationRecord
  extend Devise::Models

   # Define as roles permitidas
   ROLES = {client: 0, admin: 1}
   enum role: ROLES
    # Valida a role
  validates :role, inclusion: { in: ROLES.values }


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
