class User < ApplicationRecord
  has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :recoverable, :rememberable, :validatable # , :lockable, :trackable
  devise :trackable, :omniauthable, omniauth_providers: (%i[saml] << (:developer if Rails.env.development?)).compact

  validates :provider, :uid, presence: true

  def self.find_or_create_from_auth_hash(auth)
    identifier = { provider: auth.provider, uid: auth.uid }
    info = auth.info
    logger.info "Have auth info #{info.inspect}"
    where(identifier).first_or_create!(identifier.merge(email: info.email, first_name: info.first_name, last_name: info.last_name))
  end

  def global_id
    "#{self.id}/#{Apartment::Tenant.current}"
  end

  # Pseudo-attribute for admin dashboard
  def sign_in_summary
    ret_val = ["Signed in #{sign_in_count} times"]

    if current_sign_in_at?
      ret_val << "Currently signed in from #{current_sign_in_ip} at #{current_sign_in_at}"
    end

    if sign_in_count > 1 && last_sign_in_at?
      ret_val << "Last signed in from #{last_sign_in_ip} at #{last_sign_in_at}"
    end

    return ret_val.join(". ")
  end
end
