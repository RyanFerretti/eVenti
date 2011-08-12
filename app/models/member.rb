class Member < User

  REGISTERED = 0
  CONTESTANT = 1
  FULL = 2

  after_initialize :build_dependent

  devise :registerable, :recoverable, :confirmable

  has_one :member_summary, :dependent => :destroy
  has_one :location, :through => :member_summary

  has_many :ratings, :dependent => :destroy
  has_many :pictures, :dependent => :destroy

  accepts_nested_attributes_for :member_summary, :allow_destroy => true
  accepts_nested_attributes_for :pictures, :allow_destroy => true, :reject_if => lambda { |a| a[:image].blank? }

  scope :active, where(:state => :active)

  attr_accessible :member_summary_attributes, :pictures_attributes, :profile_name, :state

  validates_uniqueness_of :profile_name

  state_machine :state, :initial => :pending do
    event :activate do
      transition :pending => :active
    end
    event :reject do
      transition [:pending, :active] => :rejected
    end
    event :refresh do
      transition :rejected => :pending
    end
    after_transition :on => :activate do |member, transition|
      # do something
    end
    after_transition :on => :reject do |member, transition|
      case transition.from
      when :pending
        # do something for pending
      when :active
        # do something for active
      end
    end
  end

  def build_dependent
    if new_record?
      state = "pending"
      build_member_summary if member_summary.nil?
      3.times { pictures.build } if pictures.empty?
    end
  end

  def average_rating
    ratings.average(:value)
  end

  def previous(filter_state)
    scoping = Member.includes(:pictures)
    scoping = scoping.where(:state => filter_state) unless filter_state.blank?
    member = scoping.where("id < ?",id).order("id desc").page(1).per(1).first
    member || scoping.last
  end

  def next(filter_state)
    scoping = Member.includes(:pictures)
    scoping = scoping.where(:state => filter_state) unless filter_state.blank?
    member = scoping.where("id > ?",id).order("id asc").page(1).per(1).first
    member || scoping.first
  end

  def self.statuses
    [REGISTERED,CONTESTANT,FULL]
  end
end
