class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILJET_DEFAULT_FROM']
  layout 'mailer'

  # url de l'appli (FRONT)
  def application_url
    if Rails.env.production?
      ENV['PROD_HOST'] || 'localhost:3000' 
    else
      ENV['DEV_HOST'] || 'localhost:3000' 
    end
  end
end
