class MemberSummary < ActiveRecord::Base
  belongs_to :member
  belongs_to :location

  attr_accessible :profile_name, :date_of_birth, :address, :city, :state, :zip_code, :tour_market, :facebook_url,
                  :telephone, :bust, :waist, :hips, :piercings, :piercing_description, :tattoos, :tattoo_description,
                  :first_concert, :last_concert, :top_bands, :favorite_song, :relationship_status, :favorite_sport,
                  :talent, :height, :weight, :hair_color


  
end
