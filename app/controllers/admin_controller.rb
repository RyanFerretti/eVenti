class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def show_members
    @members = Member.find :all, :include => [:pictures, :member_summary]
  end
end
