class Usuarios::RegistrationsController < Devise::RegistrationsController
skip_before_filter :denegar_acceso_usuario
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  #
  protected
  #
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    logger.info '---Devise Registrations--- Parametros SignUp permitidos'
    devise_parameter_sanitizer.for(:sign_up).push(:alias, :nombre, :procedencia)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    logger.info '---Devise Registrations--- Parametros Update permitidos'
    devise_parameter_sanitizer.for(:account_update).push(:alias, :nombre, :procedencia)
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  def after_update_path_for(resource)
    return home_perfil_usuario_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
