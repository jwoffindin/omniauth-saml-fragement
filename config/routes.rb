class DomainConstraint
  include Singleton

  def self.matches?(request)
    instance.matches? request
  end

  protected

  def protected_domains
    %w(www)
  end
end

class SubdomainConstraint < DomainConstraint
  def matches?(request)
    request.subdomain.present? && protected_domains.exclude?(request.subdomain)
  end
end

class PublicDomainConstraint < DomainConstraint
  def matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do
  Healthcheck.routes(self)
  # Require password for stage environment
  mount Lockup::Engine, at: "/lockup"

  constraints PublicDomainConstraint do
    root to: "home#index"
  end

  constraints SubdomainConstraint do
    root to: "home#index", as: "tenant_guest_root"

    devise_for :users, controllers: { sessions: "users/sessions", omniauth_callbacks: "users/omniauth_callbacks" }
    devise_scope :user do
      get "sign_in", :to => "users/sessions#new", :as => :new_user_session
      delete "sign_out", :to => "users/sessions#destroy", :as => :destroy_user_session

      get "users/edit" => "devise/registrations#edit", as: :edit_user_registration
      put "users" => "devise/registrations#update", as: :user_registration
    end

    authenticate :user do
      # .... routes for authenticated users
    end
  end
end
