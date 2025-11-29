class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # Build address object for new users
  def new
    super do |resource|
      resource.build_address if resource.address.nil?
    end
  end

  # Build address object when editing profile
  def edit
    super do |resource|
      resource.build_address if resource.address.nil?
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name, 
      :last_name,
      address_attributes: [:street_address, :city, :province_id, :postal_code]
    ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, 
      :last_name,
      address_attributes: [:id, :street_address, :city, :province_id, :postal_code]
    ])
  end
end