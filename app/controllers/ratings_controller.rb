class RatingsController < ApplicationController

  # POST /ratings
  # POST /ratings.xml
  def create
    @member = Member.find params[:member_id]
    @member.ratings.create(:value => params[:vote_value])
    @upcoming_member = Member.where("id > ?",@member.id).order("id").page(2).per(1).first
    update_last_rated_user(@member)
    respond_to do |format|
      format.js { render :action => 'success' }
    end
  end
end
