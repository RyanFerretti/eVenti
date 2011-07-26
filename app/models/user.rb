class User < ActiveRecord::Base

  devise :database_authenticatable, :rememberable, :trackable, :validatable
  attr_accessible :email, :email_confirmation, :first_name, :last_name, :password, :password_confirmation, :remember_me

  protected

  def is_admin?
    false
  end

  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end
  
end
