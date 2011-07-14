class Members::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    registration_success_path resource.profile_name
  end

end