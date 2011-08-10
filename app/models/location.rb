class Location < ActiveRecord::Base

  after_save :expire_caches
  after_destroy :expire_caches

  has_many :advertisements, :dependent => :destroy
  has_many :ads, :through => :advertisements

  has_many :member_summaries
  has_many :members, :through => :member_summaries

  scope :ref_data, select("id, city, state")
  scope :active, where(:active => true)

  def name
    "#{city}, #{state}"
  end

  def to_param
    city.parameterize
  end

private

  def expire_caches
    Rails.cache.delete(:location)
  end

end
