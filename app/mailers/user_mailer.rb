class UserMailer < ApplicationMailer
  default from: ENV['MAILJET_DEFAULT_FROM']

  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = application_url

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def reset_password_instructions(user, token)
    # je récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user
    @url = "#{application_url}password/edit?reset_password_token=#{token}"

    # je permets d'envoyer l’e-mail en définissant le destinataire et le sujet.
    mail(to: @user.email, subject: 'reset_password_instructions !')
  end
end
