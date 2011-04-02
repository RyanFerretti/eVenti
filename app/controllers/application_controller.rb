class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def setup_next_profile_pictures
    current = cookies[:last_rating] || 0
    @members = Member.where("id > ?",current).order("id").page(1).per(2)
    @pictures = @members.map {|m|m.pictures.first}
    cookies[:last_rating] = current
  end

  def update_last_rated_user(member)
    cookies[:last_rating] = member.id
  end

end
