class MembersController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index]

  def index
    page = 32
    @location = params[:location_id]
    query = Member
    if @location
      #page = 12
      @location = @location.humanize.titleize
      query = Member.joins(:location).where("locations.city = ?",@location).includes(:pictures,:member_summary)
    end
    @members = query.page(params[:page]).per(page)
  end

  def activate
    member = Member.find(params[:member_id])
    member.activate!
    redirect_to :controller => :profile, :action => :show_user, :profile_name => member.profile_name
  end

  def reject
    member = Member.find(params[:member_id])
    member.reject!
    redirect_to :controller => :profile, :action => :show_user, :profile_name => member.profile_name
  end

  def refresh
    member = Member.find(params[:member_id])
    member.refresh!
    redirect_to :controller => :profile, :action => :show_user, :profile_name => member.profile_name
  end
end
