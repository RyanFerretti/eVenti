class MembersController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index]

  def index
    #cache_5
    @members = find_members().where(:state => :active)
  end

  def by_status
    all_members = find_members()
    state = params[:status]
    @members = all_members.where(:state => state)
    render :index
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

  private

  def find_members
    page = 32
    @location = params[:location_id]
    query = Member
    if @location
      #page = 12
      location_name = @location.humanize.titleize
      query = Member.joins(:location).where("locations.city = ?",location_name).includes(:pictures,:member_summary)
    end
    @members = query.page(params[:page]).per(page)
  end
end
