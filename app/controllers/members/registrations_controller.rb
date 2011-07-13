class Members::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    root_path # change to custom page path
  end

end