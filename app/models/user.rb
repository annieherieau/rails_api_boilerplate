class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :jwt_authenticatable, jwt_revocation_strategy: self
  
  def jwt_payload
    super
  end

  # associations
  # has_many :orders, dependent: :destroy

  # Callbacks
  after_create :welcome_send

  # validations
  validates :email, presence: true, uniqueness: true 

  # Email de bienvenue
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  # générer le reset_password_token (clair + crypté) et renvoie le token en clair
  def generate_password_token!
    # raw est le token en clair utilisé dans le lien de l'email 'mot de passe oublié'
    # hashed est le token encrypté (sauvegardé en  database)
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    self.reset_password_token = hashed
    self.reset_password_sent_at = Time.now.utc
    save!
    raw
  end

  # email 'mot de pass oublié' > lien pour rentrer un nouveau mot de passe
  def send_reset_password_instructions(raw)
    UserMailer.reset_password_instructions(self, raw).deliver_now
  end

  # vérifier la validité du token (lorsque le user veut recréer son mdp)
  def password_token_valid?
    (reset_password_sent_at + Devise.reset_password_within) > Time.now.utc
  end

  # reset du password
  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  # trouver le user à partir du token
  def self.get_user_from_token(token)
    # décode le token
    jwt_payload = JWT.decode(token,
    Rails.application.credentials.fetch(:secret_key_base)).first
    # détermine l'id du user
    user_id = jwt_payload['sub']
    User.find(user_id.to_s)
  end
end
