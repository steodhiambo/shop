# This must be implemented.
# sign_up_params and account_update_params
class RegistrationsController < Devise::RegistrationsController

  private

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end