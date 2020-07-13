SAML_SETUP_PROC = lambda do |env|
  options = env["omniauth.strategy"].options

  provider_settings = OmniAuthStrategy.where(name: "default").first!
  provider_settings.config.each do |k, v|
    k = k.to_sym
    options[k] = v
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :developer, fields: [:email, :first_name, :last_name], uid_field: :email
  else
    provider :saml, setup: SAML_SETUP_PROC
  end
end

# TODO: check OmniAuth.config.allowed_request_methods = %i[post]
