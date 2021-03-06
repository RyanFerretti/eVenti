class Admins::AdminsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    render "admins/index"
  end

  def locations
    @locations = group_locations Location.includes(:members)
    render "admins/locations"
  end

  def unsubscribed_members
    @members = Member.where(:state => :unsubscribed).map{|m|m.email.strip}.join(", ")
    render "admins/unsubscribed_members"
  end

private

  def group_locations(locations)
    grouping = {}
    locations.each do |l|
      grouping[l] = {:active => 0, :pending => 0, :rejected => 0, :unsubscribed => 0}
      l.members.each do |m|
        grouping[l][m.state.to_sym] += 1
      end
    end
    grouping
  end
end
