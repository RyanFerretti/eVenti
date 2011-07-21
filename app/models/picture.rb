require 'paperclip_processors/watermark'

class Picture < ActiveRecord::Base
  belongs_to :member
  has_attached_file :image, :processors => [:watermark],
                    :styles => { :thumb => "90x120>", #:small => "100x100>",# :original => "800x600>",
                                 :watermarked => { :geometry => '600x800>', :watermark_path => "#{Rails.root}/public/images/watermark.png"}
                    },
                    :storage => ENV['S3_BUCKET'] ? :s3 : :filesystem,
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    },
                    :bucket => ENV['S3_BUCKET'],
                    :path => ENV['S3_BUCKET'] ? ":class/:id/:style/:filename" : ":rails_root/public/assets/images/:id/:style/:basename.:extension",
                    :url => "/assets/images/:id/:style/:basename.:extension"


  #validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 3.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  attr_accessible :image, :approved, :credit, :image_file_name, :image_content_type, :image_file_size, :image_updated_at


end