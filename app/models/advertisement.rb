class Advertisement < ActiveRecord::Base
  belongs_to :ad
  belongs_to :location
end
