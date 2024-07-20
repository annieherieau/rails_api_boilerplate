class UserMailer < ApplicationMailer
  default from: ENV['MAILJET_DEFAULT_FROM']

  # email envoyé à la création du compte user
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 
    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = application_url
    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  # email envoyé pour "mot de pass oublié": contien le lien pour le reset password
  def reset_password_instructions(user, token)
    @user = user
    @url = "#{application_url}password/edit?reset_password_token=#{token}"
    mail(to: @user.email, subject: 'reset_password_instructions !')
  end

  # email envoyé au visiteur suite au contact form
  def visitor_contact_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = application_url
    mail(to:  @email, subject: 'RAYM Marketplacet: Nous avons reçu votre message')
  end

  # email envoyé au superAdmin suite au contact form
  def admin_contact_email(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = application_url
    mail(to: ENV["ADMIN_EMAIL"], subject: 'RAYMot it: Nouveau contact')
  end
end
