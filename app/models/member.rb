class Member < User

  devise :registerable, :recoverable, :confirmable

  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true#, :reject_if => lambda { |a| a[:image].blank? }

  attr_accessible :pictures_attributes

end
