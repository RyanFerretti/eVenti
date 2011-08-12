class RatingsController < ApplicationController

  # POST /ratings
  # POST /ratings.xml
  def create
    @previous = Member.find(params[:member_id],:include => :ratings)
    @previous.ratings.create(:value => params[:vote_value])
    @member = Member.where("id > ?",@previous.id).order("id").page(1).per(1).first
    @member = Member.first if @member.nil?
    redirect_to show_user_profile_path(:profile_name => @member.profile_name, :prev => @previous.id)
  end
end
