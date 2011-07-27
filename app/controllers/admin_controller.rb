class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def show_members
    cache_5
    @members = Member.find :all, :include => [:pictures, :member_summary]
  end
end
