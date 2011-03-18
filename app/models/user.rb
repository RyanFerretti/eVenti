class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  
end
