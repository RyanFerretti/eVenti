class Location < ActiveRecord::Base

  has_many :advertisements, :dependent => :destroy
  has_many :ads, :through => :advertisements

  scope :ref_data, select("id, city, state")
  scope :active, where(:active => true)

  def name
    "#{city}, #{state}"
  end
end
