class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    if email.nil? || password.nil?
      return nil
    end

    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    end
  end

  
end
