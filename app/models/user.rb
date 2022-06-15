class User < ApplicationRecord
    before_save { email.downcase! }
    validates :name, presence: true , length: {maximum: 50}
    ############################# email #############################################
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.(com|net|org)+\z/i
    validates :email, presence: true ,length: {maximum: 255} , format:{with: VALID_EMAIL_REGEX } ,
    uniqueness: true #{case_sensitive: false}
    has_secure_password
    validates :password, presence: true , length: {minimum: 6}
end
