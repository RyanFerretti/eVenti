class CaptchaController < ApplicationController
  def verify
    result = verify_recaptcha
    render :json => { :valid => result, :error => (result ? nil : "The captcha that was entered is incorrect, please try again.") }
  end
end
