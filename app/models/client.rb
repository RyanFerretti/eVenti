class Client < User

  devise :registerable, :recoverable, :confirmable, :timeoutable

end