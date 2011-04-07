class HomeController < ApplicationController
  def index
    setup_next_profile_pictures
    @allow_voting = allow_voting?
  end
end
