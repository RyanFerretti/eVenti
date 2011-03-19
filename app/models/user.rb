class User < ActiveRecord::Base
  after_initialize :setup_roles
  
  has_and_belongs_to_many :roles
  
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  def is_admin?
    has_role? :admin
  end

  # in models/user.rb
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def setup_roles
    roles << Role.find_by_name(self.type.underscore) if roles.empty?
  end
end
