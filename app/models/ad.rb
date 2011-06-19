class Ad < ActiveRecord::Base
  belongs_to :ad_group

  has_many :advertisements, :dependent => :destroy
  has_many :locations, :through => :advertisements

  attr_accessible :contents, :locations, :advertisements, :ad_group, :location_ids

  scope :random, lambda {|group_id| where(:group_id => group_id).first() }

  def self.random(group_id,location_id)
    group = joins(:advertisements).where(:ad_group_id => group_id).where("advertisements.location_id" => location_id)
    offset = rand group.count
    group.offset(offset).first()
  end
end
