class User < ApplicationRecord

    has_many :posts , dependent: :destroy                                   ########## post will be destroyed if user itself id destroyed
    attr_accessor :remember_token , :activation_token , :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true , length: {maximum: 50}

    ############################# email #############################################
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.(com|net|org)+\z/i
    validates :email, presence: true ,length: {maximum: 255} , format:{with: VALID_EMAIL_REGEX } ,
    uniqueness: true #{case_sensitive: false}
    has_secure_password
    validates :password, presence: true , length: {minimum: 6},allow_nil: true
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string,cost: cost)
    end

    def self.new_token 
        SecureRandom.urlsafe_base64
    end
    
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest , User.digest(remember_token))
    end

    def authenticated?(attribute ,token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        byebug
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest,nil)
    end

    def create_reset_digest
        byebug
        self.reset_token = User.new_token
        #update_columns(reset_digest: FILL_IN, reset_sent_at: FILL_IN)
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        byebug
        reset_sent_at < 2.minutes.ago
    end

    private 

    def downcase_email
        self.email = email.downcase
    end

    def create_activation_digest
        self.activation_token = User.new_token 
        self.activation_digest =User.digest(activation_token ) 
    end

   

end
