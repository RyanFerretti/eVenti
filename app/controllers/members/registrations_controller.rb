class Members::RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      super
    else
      build_resource
      flash[:alert] = "There was an error with the captcha code below. Don't worry, all of your info is still here. We just need you to re-select your pictures for upload and enter the code again, then click Register."
      @recaptcha_error = true
      respond_with_navigational(resource){ render_with_scope :new }
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    root_path # change to custom page path
  end

end