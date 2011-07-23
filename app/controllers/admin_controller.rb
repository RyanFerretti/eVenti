class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def show_members
    @members = Member.find :all, :include => [:pictures, :roles, :member_summary]
  end
end
