class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def next_profile_pictures
    current = cookies[:current_page] || {:page => 1,:id => 0}
    current_page = current[:page]
    @members = Member.where("id > ?",current[:id]).order("id").page(current_page).per(5)
    @pictures = @members.map {|m|m.pictures.first}
  end

end
