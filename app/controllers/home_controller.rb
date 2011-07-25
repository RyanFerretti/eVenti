class HomeController < ApplicationController
  #before_filter :check_logged_in, :only => [:index]

  #caches_action :index

  def index
    #cache_5
    location = params[:location_name]
    summaries = MemberSummary
    if location
      location = location.humanize.titleize
      summaries = MemberSummary.joins(:location).where("locations.city = ?",location).includes({:member => :pictures })
    end

    @members = summaries.page(params[:page]).per(8)

  end

  def rules

  end

  def terms

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

private

  def check_logged_in
    redirect_to edit_member_registration_path if member_signed_in?
  end

end
