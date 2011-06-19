class Ad < ActiveRecord::Base
  belongs_to :ad_group
  attr_accessible :contents

  scope :random, lambda {|group_id| where(:group_id => group_id).first() }

  def self.random(group_id)
    group = where(:ad_group_id => group_id)
    offset = rand group.count
    group.offset(offset).first()
  end
end
