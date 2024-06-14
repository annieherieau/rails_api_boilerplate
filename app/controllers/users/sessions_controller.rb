# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  
  private

  # POST users/sign_in
  def respond_with(_resource, _opt = {})
    @token = request.env['warden-jwt_auth.token']
    headers['Authorization'] = @token

    render json: {
      status: { code: 200,
                message: 'Signed in successfully.' },
      data: {user: current_user}
    }, status: :ok
  end

  # DELETE users/sign_out
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      current_user = set_user
    end
    
    if current_user
      render json: {
        status: { code: 200,
                  message: 'Signed out successfully.' },
        data: {user: current_user}
      }, status: :ok
    else
      render json: {
        status: { code: 401,
                  message: "User has no active session." }
      }, status: :unauthorized
    end
  end

  private
  def set_user
    @token = request.headers['Authorization'].split(' ').last
    User.get_user_from_token(@token)
  end
end
