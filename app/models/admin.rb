class Admin < User
  devise :timeoutable, :lockable

  def is_admin?
    true
  end
end
