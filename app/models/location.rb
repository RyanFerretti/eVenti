class Location < ActiveRecord::Base
  scope :ref_data, select("id, city, state")

  def name
    "#{city}, #{state}"
  end
end
