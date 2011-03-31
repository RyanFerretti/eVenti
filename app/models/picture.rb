require 'paperclip_processors/watermark'

class Picture < ActiveRecord::Base
  belongs_to :member
  has_attached_file :image, :processors => [:watermark],
                    :styles => { :thumb => "50x50>", :small => "100x100>", :original => "800x600>",
                                 :watermarked => { :geometry => '640x480>', :watermark_path => "#{Rails.root}/public/images/watermark.png"}
                    }
  attr_accessible :image, :approved, :image_file_name, :image_content_type, :image_file_size, :image_updated_at

end