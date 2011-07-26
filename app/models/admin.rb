class Admin < User

  devise :timeoutable, :lockable

  protected

  def is_admin?
    true
  end

end
