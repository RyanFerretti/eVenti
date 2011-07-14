class Members::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  def success
    @member = Member.find_by_profile_name params[:profile_name]
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    registration_success_path :profile_name => resource.profile_name, :protocol => "http", :only_path => false
  end

end