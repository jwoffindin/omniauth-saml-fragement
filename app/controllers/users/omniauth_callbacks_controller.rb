class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  protect_from_forgery except: [:saml, :developer]

  if Rails.env.development?
    def developer
      identifier = { provider: "developer", uid: params[:email] }
      user = User.where(identifier).first_or_create!(identifier.merge(email: params[:email], first_name: params[:first_name], last_name: params[:last_name]))

      if user.sign_in_count.zero?
        set_flash_message :success, :welcome_first_time, name: user.name
      else
        set_flash_message :success, :welcome_back, name: user.name
      end
      sign_in_and_redirect user, event: :authentication
    end
  end

  def saml
    resp = request.env["omniauth.auth"].extra.response_object

    resp.is_valid?

    if resp.name_id_format != "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
      logger.error "Got incorrect name_id_format", name_id_format: resp.name_id_format
    end

    user = User.find_or_create_from_auth_hash(auth_hash)

    if user.persisted?
      if user.sign_in_count.zero?
        set_flash_message :success, :welcome_first_time, name: user.name
      else
        set_flash_message :success, :welcome_back, name: user.name
      end
      sign_in_and_redirect user, event: :authentication
    else
      logger.error "Unable to persist user. Errors=#{user.errors.full_messages.inspect}", user_id: user.id
      set_flash_message :notice, :failure
      redirect_to root_path, notice: "Could not sign you in"
    end
  rescue OneLogin::RubySaml::ValidationError => e
    logger.error "Got SAML validation error", e
    redirect_to root_path, notice: "Invalid SAML response"
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
