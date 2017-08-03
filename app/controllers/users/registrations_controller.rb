class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    secret_code = SecretCode.find_by(user_id: nil, code: params[:secret_code])
    if secret_code.present?
      super
      secret_code.user = resource
      secret_code.save
    else
      flash[:error] = 'Secret code is invalid!'
      redirect_back(fallback_location: root_path)
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first, :last])
  end
end
