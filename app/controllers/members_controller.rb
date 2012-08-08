class MembersController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index,:subscribe]
  before_filter :authenticate_member!, :only => [:subscribe]

  def index
    cache_5
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

  # this is used by members who want to re-enroll in the new year's contest
  def subscribe
    current_member.subscribe
    redirect_to :controller => "members/registrations", :action => :edit
  end

  private

  def find_members
    page = 32
    @location = params[:location_id]
    query = Member.includes(:pictures,:member_summary)
    if @location
      #page = 12
      location_name = @location.humanize.titleize
      query = Member.joins(:location).where("locations.city = ?",location_name)
    end
    @members = query.page(params[:page]).per(page)
  end
end
