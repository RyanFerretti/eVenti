class RatingsController < ApplicationController

  # POST /ratings
  # POST /ratings.xml
  def create
    @current = Member.find(params[:member_id],:include => :ratings)
    @current.ratings.create(:value => params[:vote_value])
    @next = @current.next
    redirect_to show_user_profile_path(:profile_name => @next.profile_name, :prev => @current.id)
  end
end
