class ProfileController < ApplicationController
  #before_filter :authenticate_admin!, :except => [:verify_unique_email,:verify_unique_profile_name]
  
  def show_user
    @member = Member.where(:profile_name => params[:profile_name]).includes(:pictures,:member_summary).first
    unless params[:prev].blank?
      @previous = Member.find(params[:prev],:include => [:pictures])
      @voted = true
    else
      @previous = @member.previous(state_to_display)
    end
    @next = @member.next(state_to_display)
    render "members/profiles/show_user"
  end

  def verify_unique_email
    user = User.find_by_email params[:val]
    render :json => { :valid => user.nil?, :error => "That email address is already taken" }
  end

  def verify_unique_profile_name
    user = Member.find_by_profile_name params[:val]
    render :json => { :valid => user.nil?, :error => "That profile url is already taken" }
  end
  
end