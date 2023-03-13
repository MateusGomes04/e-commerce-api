class User < ApplicationRecord
  extend Devise::Models
  include Devise::JWT::RevocationStrategies::JTIMatcher
   # Define as roles permitidas
   enum role: {client: 0, admin: 1}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super.merge('foo' => 'bar')
  end

def change
  add_column :users, :jti, :string, null: false
  add_index :users, :jti, unique: true
  # If you already have user records, you will need to initialize its `jti` column before setting it to not nullable. Your migration will look this way:
  # add_column :users, :jti, :string
  # User.all.each { |user| user.update_column(:jti, SecureRandom.uuid) }
  # change_column_null :users, :jti, false
  # add_index :users, :jti, unique: true

end
  
end