class Role < ActiveRecord::Base

  after_save :expire_caches
  after_destroy :expire_caches

  has_and_belongs_to_many :users

  ADMIN  = 1
  CLIENT = 2
  MEMBER = 3

  scope :c_all, Rails.cache.fetch(:role){self.all}

private

  def expire_caches
    Rails.cache.delete(:role)
  end

end
