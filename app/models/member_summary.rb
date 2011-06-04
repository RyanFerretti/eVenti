class MemberSummary < ActiveRecord::Base
  belongs_to :member
  belongs_to :location

  attr_accessible :date_of_birth, :address, :city, :state, :zip_code, :tour_market, :facebook_url,
                  :telephone, :bust, :waist, :hips, :piercings, :piercing_description, :tattoos, :tattoo_description,
                  :first_concert, :last_concert, :top_bands_1, :top_bands_2, :top_bands_3, :favorite_song, :relationship_status, :favorite_sport,
                  :talent, :height_feet, :height_inches, :weight, :hair_color, :address_more, :cell_phone, :experience,
                  :eyes, :eyes_other, :ethnicity, :ethnicity_other


  
end
