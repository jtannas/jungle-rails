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

end
