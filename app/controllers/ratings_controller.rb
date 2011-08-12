class RatingsController < ApplicationController
  before_filter :setup_rating, :only => [:create]

  def create
    @current = Member.find(params[:member_id])
    @current.ratings.create(:value => @rating)
    @next = @current.next(state_to_display)
    redirect_to show_user_profile_path(:profile_name => @next.profile_name, :prev => @current.id)
  end

  private

  def setup_rating
    default_rating = 5
    @rating = params[:vote_value].to_i || default_rating
    @rating = default_rating if @rating < 1 || @rating > 10
  end
end
