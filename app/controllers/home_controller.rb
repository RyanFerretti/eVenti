class HomeController < ApplicationController
  #before_filter :authenticate_member!

  def index
    
  end

  def index_temp
    @city = params[:city]
    @rating = params[:rating]
    @level = params[:level]
    
    @locations = Location.ref_data
    unless @city.blank?
      @members = Member.joins(:member_summary).where("member_summaries.location_id" => @city)
    else
      @members = Member.all
    end

    unless @rating.blank?
      if @rating == "descending"
        @members = @members.sort {|x,y| y.average_rating <=> x.average_rating  }
      elsif @rating == "ascending"
        @members = @members.sort {|x,y| x.average_rating <=> y.average_rating  }
      else
        r = @rating.to_i
        @members = @members.select {|m| m.average_rating >= r && m.average_rating < (r + 1) }
      end
    end

    # check level
  end

  def old_index
    setup_next_profile_pictures
    @allow_voting = allow_voting?
  end
end
