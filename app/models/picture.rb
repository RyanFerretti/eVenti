class Picture < ActiveRecord::Base
  belongs_to :member
  has_attached_file :image, :styles => { :thumb => "50x50>", :small => "100x100>", :original => "800x600>" }
  attr_accessible :image, :approved, :image_file_name, :image_content_type, :image_file_size, :image_updated_at

end
