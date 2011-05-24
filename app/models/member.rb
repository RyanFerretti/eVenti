class Member < User

  after_initialize :build_dependent

  devise :registerable, :recoverable, :confirmable

  has_one :member_summary, :dependent => :destroy

  has_many :ratings, :dependent => :destroy
  has_many :pictures, :dependent => :destroy

  accepts_nested_attributes_for :member_summary, :allow_destroy => true
  accepts_nested_attributes_for :pictures, :allow_destroy => true, :reject_if => lambda { |a| a[:image].blank? }

  attr_accessible :pictures_attributes, :profile_name

  validates_uniqueness_of :profile_name

  def build_dependent
    build_member_summary if member_summary.nil?
    3.times { pictures.build } if pictures.empty?
  end

  def average_rating
    ratings.average(:value)
  end

end
