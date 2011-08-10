class AdminController < ApplicationController
  before_filter :authenticate_admin!

  def index

  end

  def locations
    @locations = Location.includes(:members)
  end
end
