class StaticPagesController < ApplicationController
  respond_to :json

  # GET /
  def hello_world
    render json: {
      status: {code: 200,
      message: "Hello, World !"},
    }, status: :ok
  end
  # POST /contact
  def send_contact_email
    send_to_visitor = UserMailer.visitor_contact_email(params[:static_pages]).deliver_now
    send_to_admin = UserMailer.admin_contact_email(params[:static_pages]).deliver_now
    
    if send_to_admin
      render json: {
        status: {code: 200,
        message: "Votre message a bien été envoyé."},
      }, status: :ok
    end
  end
end
