class RatingsController < ApplicationController

  # POST /ratings
  # POST /ratings.xml
  def create
    rating = params[:vote_value].to_i || 5
    rating = 5 if rating < 1 || rating > 10
    
    @current = Member.find(params[:member_id])
    @current.ratings.create(:value => rating)
    @next = @current.next(state_to_display)
    
    redirect_to show_user_profile_path(:profile_name => @next.profile_name, :prev => @current.id)
  end
end
