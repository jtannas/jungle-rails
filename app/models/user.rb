class User < ActiveRecord::Base

  has_many :reviews

  validates :name,
    presence: true
  validates :email,
    presence: true,
    :uniqueness => {:case_sensitive => false}
  validates :password,
    presence: true,
    length: { minimum: 8 }
  validates :password_confirmation,
    presence: true,
    length: { minimum: 8 }
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = User.where("lower(email) = ?", email.strip.downcase).first unless email == nil
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
