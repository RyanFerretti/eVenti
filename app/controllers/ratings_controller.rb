class RatingsController < ApplicationController

  # POST /ratings
  # POST /ratings.xml
  def create
    @member = Member.find params[:member_id]
    @member.ratings.create(:value => params[:vote_value])
    paged_members = Member.where("id > ?",@member.id).order("id").page(1).per(2)
    @upcoming_member = paged_members.second
    if @upcoming_member.nil?
      unless paged_members.first.nil?
        @upcoming_member = Member.first
      else
        @upcoming_member = Member.where("id > ?",0).order("id").page(2).per(1).first
      end
    end
    update_last_rated_user(@member)
    respond_to do |format|
      format.js { render :action => 'success' }
    end
  end
end
