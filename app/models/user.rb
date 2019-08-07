class User < ApplicationRecord
  has_one :user_role 
   belongs_to :user_role , optional: true
   
	attr_accessor :remember_token, :activation_token, :reset_token
	 before_create :create_activation_digest	



def self.find_or_create_from_auth_hash(auth)
# binding.pry
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  
       user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.first_name || auth.info.name 
      # user.last_name = auth.info.last_name
       user.email = auth.info.email
      user.remote_avatar_url = auth.info.image
      # user.user_role.name = "User"
       #user.password = SecureRandom.urlsafe_base64
      user.save(validate: false)
    end
  end

	  # Activates an account.
  def activate
    update_attribute(:activated,true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token =  User.new_token

  update_attribute(:reset_digest ,  User.digest(reset_token))
    update_attribute(:reset_sent_at , Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

 



  mount_uploader :avatar, AvatarUploader
    
    before_save { self.email = email&.downcase }
    before_create {self.user_role_id = UserRole.find_by(name:"User")&.id}

 validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, on: :create
 has_secure_password(validations: false)
 validates :password, presence: true, on: :create, length: {maximum: 18}   

 # Returns the hash digest of the given string.


 def User.digest(string)
   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
   BCrypt::Password.create(string, cost: cost)
 end


def User.new_token
    SecureRandom.urlsafe_base64
  end



def remember
    self.remember_token = User.new_token
    update_attribute(:password_digest, User.digest(remember_token))
  end

def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end



  def forget
    update_attribute(:remember_digest, nil)
  end





def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end




  private

 

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
       # self.activation_digest = User.digest(activation_token)
    end
end
