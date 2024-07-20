class ApplicationController < ActionController::API

  protected
  
  def is_admin?
    user_signed_in? && current_user.admin
  end

  def authenticate_admin!
    if (!is_admin?)
      render json: {
        status: { code: 401,
                  message: "Doit être un utilisateur administrateur." }
      }, status: :unauthorized
    end
  end
  
end
