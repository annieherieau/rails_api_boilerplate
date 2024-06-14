# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: %i[update]
  before_action :set_user, only: %i[ update ]
  
  respond_to :json

  # POST /users
  def create
    super
  end

  # PUT /users
  def update
    if @user.nil?
      render :json => { errors: "User not found" }, status: 404
    end

    if @user.valid_password?(params[:current_password])
      if params.has_key?(:password)

      end
      if @user.update(update_user_params)
        render json: {
          status: { code: 200,
           message: 'User updated successfully.' },
          data: { user: @user}
        }, status: :ok
          
        else
          puts @listing.errors.full_messages
          render json: {
            errors: @user.errors}, status: 422
        end
    else
      render json: {errors: "wrong password"}, status: 401
    end
  end
  
  private

  def set_user
    @token = request.headers['Authorization'].split(' ').last
    @user = User.get_user_from_token(@token)
  end

  def update_user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
