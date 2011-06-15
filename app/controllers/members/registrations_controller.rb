class Members::RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      super
    else
      build_resource
      flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code and click submit."
      @recaptcha_error = true
      respond_with_navigational(resource){ render_with_scope :new }
    end
  end
end