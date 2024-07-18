# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[address city postal_code province_id])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[address city postal_code province_id])
  end
end
