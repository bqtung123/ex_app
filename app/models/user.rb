class User < ApplicationRecord
    before_save :downcase
    validates :name , presence: true , length: {maximum: 50}
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email , presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
                            uniqueness: true
    def downcase
        self.email = email.downcase
    end
    validates :password, presence: true, length: {minimum: 6}
    has_secure_password
end
