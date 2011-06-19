class AdGroup < ActiveRecord::Base
  has_many :ads
  attr_accessible :name
end
