class Rating < ActiveRecord::Base
  belongs_to :member
  attr_accessible :member_id, :value
end
