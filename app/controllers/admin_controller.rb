class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def locations
    @locations = Location.includes(:members)
  end
end
