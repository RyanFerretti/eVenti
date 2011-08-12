class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def cache_5
    response.headers['Cache-Control'] = 'public, max-age=300'
  end

  def setup_next_profile_pictures
    current = session[:last_rating] || 0
    @members = Member.where("id > ?",current).order("id").page(1).per(2)
    @pictures = @members.map {|m|m.pictures.first}
    session[:last_rating] = current
  end

  def update_last_rated_user(member)
    session[:last_rating] = member.id
  end

  def allow_voting?
    true
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || (resource.is_a?(Admin)? admins_root_path : edit_member_registration_path)
  end
end
