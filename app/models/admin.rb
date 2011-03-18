class Admin < User
  devise :timeoutable, :lockable

end
