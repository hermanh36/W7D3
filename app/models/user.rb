class User < ApplicationRecord
  validates :username, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :username, :session_token, uniqueness: true


  after_initialize :ensure_session_token

  attr_reader :password
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    password_object = BCrypt::Password.new(self.password_digest)
    password_object.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  

end