class Member < User

  devise :registerable, :recoverable, :confirmable

end
