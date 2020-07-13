# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    redirect_to root_path
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  def destroy
    # Preserve the saml_uid in the session
    saml_uid = session["saml_uid"]
    super do
      session["saml_uid"] = saml_uid
    end
  end

  protected

  def after_sign_out_path_for(_)
    if session["saml_uid"]
      if current_tenant.website_url.present?
        current_tenant.website_url
      else
        request.base_url
      end
    else
      super
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
