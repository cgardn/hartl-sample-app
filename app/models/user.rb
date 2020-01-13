class User < ApplicationRecord

  attr_accessor :remember_token
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 }, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true,
                    length: { minimum: 9 }

  # Returns the hash digest of the given string
  #   - used for generating test passwords for integration tests
  #     on login/logout and other things that require fake users
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a url safe random token, using a-z, A-Z, 0-9, -, _
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Creating a remember token and saving a one-way encrypted digest of it in the
  #   database for this User. This and an encrypted username will be checked 
  #   against the un-digested token pulled from a user's cookies (after decrypting
  #   the username) to verify who this person is and logging them in automatically.
  #   So they aren't really maintaining a session while away from the site, we're 
  #   just using this machinery to auto-log them in when they arrive back at the site
  def remember
    self.remember_token = User.new_token

    # update_attribute bypasses validations, since we don't have user's password
    #   here, which is normally necessary for changing records on the table
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  #   - used for remembering a User who has previously logged in, who is now
  #     returning for a new session
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
