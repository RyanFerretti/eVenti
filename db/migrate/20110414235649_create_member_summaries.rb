class CreateMemberSummaries < ActiveRecord::Migration
  def self.up
    create_table :member_summaries do |t|
      t.references :member
      t.references :location
      t.date :date_of_birth
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :facebook_url
      t.string :telephone
      t.string :height
      t.string :weight
      t.string :hair_color
      t.string :bust
      t.string :waist
      t.string :hips
      t.string :piercings
      t.string :tattoos
      t.string :first_concert
      t.string :last_concert
      t.string :top_bands
      t.string :favorite_song
      t.string :relationship_status
      t.string :favorite_sport
      t.string :talent
      t.timestamps
    end
  end

  def self.down
    drop_table :member_summaries
  end
end