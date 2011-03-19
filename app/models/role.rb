class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  ADMIN  = 1
  CLIENT = 2
  MEMBER = 3

end
