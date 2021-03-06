# frozen_string_literal: true

class Spree::UserRegistrationsController < Devise::RegistrationsController
  helper 'spree/base', 'spree/store'

  include Spree::Core::ControllerHelpers::Auth
  include Spree::Core::ControllerHelpers::Common
  include Spree::Core::ControllerHelpers::Order
  include Spree::Core::ControllerHelpers::Store

  before_action :check_permissions, only: %i[edit update]
  skip_before_action :require_no_authentication

  def create
    build_resource(spree_user_params)
    if resource.save
      p = Profile.new
      p.spree_user_id = resource.id
      p.save!
      set_flash_message(:notice, :signed_up)
      if resource.confirmed_at.nil?
        session[:user_id] = resource.id
        respond_with resource, location: main_app.confirmation_path
      else
        sign_in(:spree_user, resource)
        session[:spree_user_signup] = true
        respond_with resource, location: main_app.root_path
      end
    else
      clean_up_passwords(resource)
      respond_with(resource) do |format|
        format.html { render :new }
      end
    end
  end

  protected

  def translation_scope
    'devise.user_registrations'
  end

  def check_permissions
    authorize!(:create, resource)
  end

  private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes | [:email])
  end
end
