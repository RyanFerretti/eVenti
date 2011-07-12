class Location < ActiveRecord::Base

  after_save :expire_caches
  after_destroy :expire_caches

  has_many :advertisements, :dependent => :destroy
  has_many :ads, :through => :advertisements

  scope :ref_data, select("id, city, state")

  scope :active, where(:active => true)
  scope :c_active, Rails.cache.fetch(:location){where(:active => true).all}

  def name
    "#{city}, #{state}"
  end

private

  def expire_caches
    Rails.cache.delete(:location)
  end

end
