class HomeController < ApplicationController
  before_filter :authenticate_member!

  def index
    setup_next_profile_pictures
    @allow_voting = allow_voting?
  end
end
